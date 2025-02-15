//
//  RatesVC.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 12.02.2025.
//

import UIKit

extension RatesVC: Makeable {
    static func make() -> RatesVC { RatesVC() }
}

final class RatesVC: BaseVC, ViewModelContainer {
    // MARK: - Public Properties
    var viewModel: RatesVM?
    
    // MARK: - Lifecycle
    override func setupVC() {
        super.setupVC()
        setupNavigationBarTitle()
    }
    
    // MARK: - Setup
    private func setupNavigationBarTitle() {
        navigationItem.title = R.string.localizable.exchangeRates()
    }
}
