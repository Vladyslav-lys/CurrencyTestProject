//
//  BaseService.swift
//  Services
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import DatabaseLayer
import NetworkLayer

class BaseService {
    func perform<T>(completion: @escaping () async throws -> T) async throws -> T {
        do {
            return try await completion()
        } catch let error as ServiceError {
            throw error
        }
    }
}
