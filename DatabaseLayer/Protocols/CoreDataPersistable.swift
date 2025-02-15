//
//  CoreDataPersistable.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import CoreData

typealias Context = NSManagedObjectContext

protocol CoreDataPersistable {
    associatedtype ManagedObject: NSManagedObject
    
    func update(_ object: ManagedObject, context: Context) throws
}

extension CoreDataPersistable {
    func update(_ object: ManagedObject) throws {
        try update(object)
    }
}
