//
//  RatesFactory.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import UIKit

protocol RatesFactoryProtocol: AnyObject {
    func makeRatesVC() -> RatesVC
}

final class RatesFactory: BaseFactory, RatesFactoryProtocol {
    func makeRatesVC() -> RatesVC {
        makeController {
            $0.viewModel = RatesVM(useCases: useCases)
        }
    }
}
