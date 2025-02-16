//
//  Platform.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import UIKit
import NetworkLayer
import DatabaseLayer
import Services

final class Platform: UseCasesProvider {
    // MARK: - Public Properties
    let rates: RatesUseCases
    
    // MARK: - Private Properties
    private let apiKeyInterceptor: ApiKeyIncerceptor
    
    // MARK: - Initialize
    init() {
        apiKeyInterceptor = ApiKeyIncerceptor()
        let network = Network(baseURL: Environment.current.baseURL, interceptors: [apiKeyInterceptor])
        let database = CDDatabase()
        let serviceContext = ServiceContext(network: network, database: database)
        apiKeyInterceptor.setApiKey(Environment.current.apiKey)
        rates = RatesService(context: serviceContext)
    }
    
    // MARK: - AppDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }
}
