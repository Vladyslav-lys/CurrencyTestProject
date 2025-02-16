//
//  AppCoordinator.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import UIKit

final class AppCoordinator {
    // MARK: - Public Properties
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Private Properties
    private let useCases: UseCasesProvider
    private var ratesCoordinator: Coordinator?
    
    // MARK: - Initialize
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        start()
    }
    
    private func start() {
        let presenter = UINavigationController()
        window.rootViewController = presenter
        ratesCoordinator = RatesCoordinator(presenter: presenter, useCases: useCases)
        ratesCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
