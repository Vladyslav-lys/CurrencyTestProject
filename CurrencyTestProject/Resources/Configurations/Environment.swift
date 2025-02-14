//
//  Environment.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import Foundation

final class Environment {
    // MARK: - ConfigurationKey
    enum ConfigurationKey: String, CaseIterable {
        case apiKey = "API_KEY"
        case baseUrl = "BASE_URL"
    }

    // MARK: - Shared instance
    static let current = Environment()

    // MARK: - Properties
    var apiKey: String { value(for: .apiKey) }
    
    var baseURL: URL {
        guard let url = URL(string: value(for: .baseUrl)) else {
            fatalError("Base URL is not valid")
        }
        return url
    }
    
    // MARK: - Lifecycle
    private init() {}

    // MARK: - Methods
    func value<T>(for key: ConfigurationKey) -> T {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? T else {
            fatalError("No value satysfying requirements")
        }
        return value
    }
}
