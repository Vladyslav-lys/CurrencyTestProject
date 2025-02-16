//
//  RatesUseCases.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Foundation

public protocol RatesUseCases {
    func getLatesRates() async throws -> [Rate]
}
