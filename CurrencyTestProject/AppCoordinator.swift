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
    
    // MARK: - Initialize
    init() {
        start()
    }
    
    private func start() {
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}
