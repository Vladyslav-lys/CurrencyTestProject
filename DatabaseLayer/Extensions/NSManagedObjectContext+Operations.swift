//
//  NSManagedObjectContext+Operations.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import CoreData

extension NSManagedObjectContext {
    func fetchAll<T: NSManagedObject>(
        typeEntity: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false
        let result = try self.fetch(fetchRequest)
        return result.compactMap{$0 as? T}
    }
    
    func fetchFirst<T: NSManagedObject>(
        typeEntity: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> T {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.fetchLimit = 1
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try fetch(fetchRequest)
            if let value = result.compactMap({$0 as? T}).first {
                return value
            } else {
                throw DatabaseError.notFound
            }
        } catch {
            throw DatabaseError.notFound
        }
    }
    
    func fetchOrCreate<T: CoreDataPersistable>(for object: T) throws -> T.ManagedObject {
        let predicate = object.findPredicate()
        var first: T.ManagedObject!
        do {
            first = try fetchFirst(typeEntity: T.ManagedObject.self, predicate: predicate)
        } catch {
            if let error = (error as? DatabaseError), case .notFound = error {
                return T.ManagedObject(entity: T.ManagedObject.entity(), insertInto: self)
            } else {
                throw error
            }
        }
        return first
    }
    
    func saveIfNeeded() throws {
        guard hasChanges else { return }
        try save()
    }
}
