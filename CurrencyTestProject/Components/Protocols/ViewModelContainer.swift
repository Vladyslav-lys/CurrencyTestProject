//
//  ViewModelContainer.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Foundation

protocol ViewModelContainer: AnyObject {
    associatedtype ViewModel: BaseVM
    var viewModel: ViewModel? { get set }
    func setupViewModel()
}

extension ViewModelContainer where Self: BaseVC {
    func setupViewModel() {
        viewModel?.$isLoading
            .sink { [weak self] value in
                self?.isLoading = value
            }
            .store(in: &subscriptions)
        
        viewModel?.$error
            .sink { [weak self] value in
                self?.error = value
            }
            .store(in: &subscriptions)
    }
}
