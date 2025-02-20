//
//  Rate+Response.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import RatesAPI

extension Rate {
    init(from response: LatestRatesQuery.Data.Latest) {
        date = DateFormatter.iso8601.date(from: response.date) ?? .now
        baseCurrency = response.baseCurrency
        quoteCurrency = response.quoteCurrency
        quote = NSDecimalNumber(string: response.quote)
    }
}
