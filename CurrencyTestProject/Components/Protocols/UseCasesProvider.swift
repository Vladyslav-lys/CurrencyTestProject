//
//  UseCasesProvider.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Services

protocol HasRatesUseCases {
    var rates: RatesUseCases { get }
}

typealias UseCases = HasRatesUseCases

protocol UseCasesProvider: UseCases {}
