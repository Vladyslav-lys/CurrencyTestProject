//
//  BaseVM.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Combine

class BaseVM {
    @Published var isLoading = false
    @Published var error: Error?
    var subscriptions: Set<AnyCancellable> = []
    
    deinit {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    func perform(completion: @escaping () async throws -> Void) {
        Task { @MainActor in
            do {
                isLoading = true
                try await completion()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
