//
//  AppDelegate.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 12.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Public Properties
    var window: UIWindow?
    
    // MARK: - Private Properties
    private lazy var platform = Platform()
    private lazy var appCoordinator = AppCoordinator()
    
    // MARK: - Methods
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = appCoordinator.window
        return platform.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

