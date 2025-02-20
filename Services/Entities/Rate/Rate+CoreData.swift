//
//  Rate+CoreDataPersistable.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import DatabaseLayer

extension Rate: CoreDataPersistable {
    public var primaryKeyValues: [String: Any] {
        [
            #keyPath(ManagedObject.baseCurrency): baseCurrency,
            #keyPath(ManagedObject.quoteCurrency): quoteCurrency
        ]
    }
    
    public func update(_ object: CDExchangeRate) throws {
        object.date = date
        object.baseCurrency = baseCurrency
        object.quote = quote
        object.quoteCurrency = quoteCurrency
        object.isFavorite = isFavorite ?? object.isFavorite
    }
}

extension Rate {
    init(from cdRate: CDExchangeRate) {
        self.init(
            baseCurrency: cdRate.baseCurrency,
            quoteCurrency: cdRate.quoteCurrency,
            quote: cdRate.quote,
            date: cdRate.date,
            isFavorite: cdRate.isFavorite
        )
    }
}
