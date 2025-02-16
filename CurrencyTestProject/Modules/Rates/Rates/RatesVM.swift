//
//  ExchangeRatesVM.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Services

final class RatesVM: BaseVM, UseCasesConsumer {
    typealias UseCases = HasRatesUseCases
    
    // MARK: - Public properties
    var useCases: UseCases
    @Published var latestRates: [Rate] = []
    
    // MARK: - Initialize
    init(useCases: UseCases) {
        self.useCases = useCases
        super.init()
        getLatestRates()
    }
    
    // MARK: - Public methods
    func getLatestRates() {
        perform { [weak self] in
            guard let self else { return }
            self.latestRates = try await self.useCases.rates.getLatesRates()
        }
    }
}
