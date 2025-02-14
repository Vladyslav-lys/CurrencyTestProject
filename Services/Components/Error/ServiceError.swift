//
//  ServiceError.swift
//  Services
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import DatabaseLayer
import NetworkLayer

public enum ServiceError: Error {
    case network(error: NetworkError)
    case database(error: DatabaseError)
    case undefined
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network(let error): error.errorDescription
        case .database(let error): error.errorDescription
        default: nil
        }
    }
}
