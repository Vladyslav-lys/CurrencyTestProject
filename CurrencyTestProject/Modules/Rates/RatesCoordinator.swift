//
//  ExchangeRatesCoordinator.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import UIKit

final class RatesCoordinator: Coordinator {
    // MARK: - Private properties
    private lazy var factory: RatesFactoryProtocol = RatesFactory(coordinator: self)
    private unowned var presenter: UINavigationController
    
    // MARK: - Lifecycle
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    deinit {
        print(#function, " \(self)")
    }
    
    func start(animated: Bool) {
        let ratesVC = factory.makeRatesVC()
        presenter.pushViewController(ratesVC, animated: animated)
    }
}
