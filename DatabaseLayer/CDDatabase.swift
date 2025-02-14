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
    public init(containerName: String = "Model") {
        persistentContainer = NSPersistentContainer(name: containerName)
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
        case .main:
            return mainContext
        case .background:
            return backgroundContext
        case .current:
            return Thread.isMainThread ? mainContext : backgroundContext
        }
    }
}

// MARK: - Fetch
extension CDDatabase {
    func fetchAll<T: NSManagedObject>(
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
    func save<T: CoreDataPersistable>(_ value: T, in context: Context = .background) async throws -> T {
        try await perform(in: managedObjectContext(for: context)) { context in
            let object = T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: context)
            try value.update(object, context: context)
            try context.saveIfNeeded()
            return value
        }
    }
    
    func save<T: CoreDataPersistable>(_ values: [T], in context: Context = .background) async throws -> [T.ManagedObject] {
        try await perform(in: managedObjectContext(for: context)) { context in
            let objects = try values.map { value -> T.ManagedObject in
                let object = T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: context)
                try value.update(object, context: context)
                return object
            }
            try context.saveIfNeeded()
            return objects
        }
    }
}

// MARK: - Update
extension CDDatabase {
    func update<T: CoreDataPersistable>(
        _ object: T,
        in context: Context = .background,
        update: @escaping ((T, T.ManagedObject)) throws -> Void
    ) async throws {
        try await perform(in: managedObjectContext(for: context)) {
            try update((object, T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: $0)))
            try $0.saveIfNeeded()
        }
    }
    
    func update<T: CoreDataPersistable>(
        _ values: [T],
        in context: Context = .background,
        update: @escaping ((T, T.ManagedObject)) throws -> Void
    ) async throws {
        try await perform(in: managedObjectContext(for: context)) { context in
            try values.forEach { value in
                let object = T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: context)
                try value.update(object, context: context)
                try update((value, object))
            }
            try context.saveIfNeeded()
        }
    }
}
