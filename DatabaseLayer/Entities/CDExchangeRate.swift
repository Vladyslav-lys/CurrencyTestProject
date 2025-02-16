//
//  CDExchangeRate.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//
//

import CoreData

@objc(CDExchangeRate)
public class CDExchangeRate: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExchangeRate> {
        NSFetchRequest<CDExchangeRate>(entityName: "CDExchangeRate")
    }

    @NSManaged public var baseCurrency: String
    @NSManaged public var quoteCurrency: String
    @NSManaged public var quote: NSDecimalNumber
    @NSManaged public var date: Date
    @NSManaged public var isFavorite: Bool
}
