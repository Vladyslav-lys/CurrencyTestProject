//
//  CDDatabase.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import CoreData

public final class CDDatabase {
    // MARK: - Context
    public enum Context {
        case main
        case background
        case current
    }
    
    // MARK: - Private Properties
    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    // MARK: - Public Properties
    public let mainContext: NSManagedObjectContext
    
    // MARK: - Lifecycle
    public init(containerName: String = "CurrencyTestProject") {
        persistentContainer = NSPersistentContainer(name: containerName)
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        self.persistentContainer.viewContext.mergePolicy = NSMergePolicy.overwrite
        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        self.persistentContainer.persistentStoreDescriptions.append(description)
        persistentContainer.loadPersistentStores { _, error in
            guard let error = error as NSError? else { return }
            fatalError("LoadPersistentStores: Unresolved error \(error), \(error.userInfo)")
        }
        
        mainContext = persistentContainer.viewContext
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDidSaveNotification),
            name: .NSManagedObjectContextDidSave,
            object: nil
        )
    }
    
    @objc private func handleDidSaveNotification(_ notification: Notification) {
        mainContext.mergeChanges(fromContextDidSave: notification)
    }
}

// MARK: - Perform
extension CDDatabase {
    private func perform<T>(
        in context: NSManagedObjectContext,
        action: @escaping (NSManagedObjectContext) throws -> T
    ) async throws -> T {
        try await withUnsafeThrowingContinuation { continuation in
            context.perform {
                do {
                    continuation.resume(returning: try action(context))
                } catch {
                    continuation.resume(throwing: DatabaseError.underlying(error))
                }
            }
        }
    }
    
    private func managedObjectContext(for context: Context) -> NSManagedObjectContext {
        switch context {
        case .main: mainContext
        case .background: backgroundContext
        case .current: Thread.isMainThread ? mainContext : backgroundContext
        }
    }
}

// MARK: - Fetch
extension CDDatabase {
    public func fetchAll<T: NSManagedObject>(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        in context: Context = .background
    ) async throws -> [T] {
        try await perform(in: managedObjectContext(for: context)) {
            try $0.fetchAll(typeEntity: T.self, predicate: predicate, sortDescriptors: sortDescriptors)
        }
    }
}

// MARK: - Save
extension CDDatabase {
    public func save<T: CoreDataPersistable>(_ value: T, in context: Context = .background) async throws -> T {
        try await perform(in: managedObjectContext(for: context)) { context in
            let object = T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: context)
            try value.update(object)
            try context.saveIfNeeded()
            return value
        }
    }
    
    public func save<T: CoreDataPersistable>(_ values: [T], in context: Context = .background) async throws -> [T.ManagedObject] {
        try await perform(in: managedObjectContext(for: context)) { context in
            let objects = try values.map { value -> T.ManagedObject in
                let object = T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: context)
                try value.update(object)
                return object
            }
            try context.saveIfNeeded()
            return objects
        }
    }
}

// MARK: - Update
extension CDDatabase {
    public func update<T: CoreDataPersistable>(_ object: T, in context: Context = .background) async throws -> T.ManagedObject {
        try await perform(in: managedObjectContext(for: context)) {
            let entity = try $0.fetchOrCreate(for: object)
            try object.update(entity)
            try $0.saveIfNeeded()
            return entity
        }
    }
    
    public func update<T: CoreDataPersistable>( _ values: [T], in context: Context = .background) async throws -> [T.ManagedObject] {
        try await perform(in: managedObjectContext(for: context)) { context in
            let values = try values.map { object in
                let entity = try context.fetchOrCreate(for: object)
                try object.update(entity)
                return entity
            }
            try context.saveIfNeeded()
            return values
        }
    }
}

// MARK: - Remove
public extension CDDatabase {
    func removeAll<T: NSManagedObject>(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        in context: Context = .background
    ) async throws -> [T] {
        let managedContext = managedObjectContext(for: context)
        let objects: [T] = try await fetchAll(predicate: predicate,sortDescriptors: sortDescriptors, in: context)
        objects.forEach {
            managedContext.delete($0)
        }
        try managedContext.saveIfNeeded()
        return objects
    }
}
