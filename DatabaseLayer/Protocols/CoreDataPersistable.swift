//
//  CoreDataPersistable.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import CoreData

public typealias Context = NSManagedObjectContext

public protocol CoreDataPersistable {
    associatedtype ManagedObject: NSManagedObject
    var primaryKeyValues: [String: Any] { get }
    
    func update(_ object: ManagedObject) throws
}

extension CoreDataPersistable {
    func findPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []
        primaryKeyValues.forEach { key, value in
            predicates.append(NSPredicate(format: "%K == %@", argumentArray: [key, value]))
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}
