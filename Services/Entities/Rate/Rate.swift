//
//  Rate.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Foundation

public struct Rate: Hashable, Equatable {
    public var baseCurrency: String
    public var quoteCurrency: String
    public var quote: NSDecimalNumber
    public var date: Date
    public var isFavorite: Bool
}
