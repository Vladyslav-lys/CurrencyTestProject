//
//  CoreDataPersistable.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import CoreData

typealias Context = NSManagedObjectContext

protocol CoreDataPersistable {
    associatedtype ManagedObject: NSManagedObject, PrimaryKeyProvider
    var primaryKeyValue: Any { get }
    
    func update(_ object: ManagedObject, context: Context) throws
}

extension CoreDataPersistable {
    func findPredicate() -> NSPredicate {
        NSPredicate(format: "%K == %@", argumentArray: [ManagedObject.primaryKey, primaryKeyValue])
    }
    
    func update(_ object: ManagedObject) throws {
        try update(object)
    }
}

extension CoreDataPersistable where Self: Identifiable {
    var primaryKeyValue: Any { id }
}
