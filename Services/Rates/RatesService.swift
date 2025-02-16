//
//  RatesService.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import RatesAPI
import DatabaseLayer

public final class RatesService: BaseService, RatesUseCases {
    // MARK: - Private Properties
    private let context: ServiceContext
    
    // MARK: - Initialize
    public init(context: ServiceContext) {
        self.context = context
    }
    
    // MARK: - Use Cases
    public func getLatesRates() async throws -> [Rate] {
        try await perform { [unowned self] in
            let predicate = NSPredicate(format: "\(#keyPath(CDExchangeRate.date)) == %@", argumentArray: [Date.now.startOfDay])
            let rates = try await context.database.fetchAll(
                predicate: context.network.isConnected.value ? predicate : nil,
                sortDescriptors: [.init(key: #keyPath(CDExchangeRate.quoteCurrency), ascending: true)]
            )
            .map(Rate.init)
            
            if rates.isEmpty && context.network.isConnected.value {
                let networkRates = try await context.network.fetch(query: LatestRatesQuery())
                    .latest
                    .map(Rate.init)
                let rates = try await context.database.update(networkRates)
                    .sorted { $0.quoteCurrency < $1.quoteCurrency }
                return rates
            } else {
                return rates
            }
        }
    }
}
