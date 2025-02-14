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
    
    func saveIfNeeded() throws {
        guard hasChanges else { return }
        try save()
    }
}
