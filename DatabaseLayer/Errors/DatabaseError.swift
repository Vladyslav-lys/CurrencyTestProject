//
//  DatabaseError.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import Foundation

public enum DatabaseError: Error {
    case notFound
    case underlying(Error)
    case unknown
}

extension DatabaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound: "Data not found"
        case .underlying(let error): error.localizedDescription
        case .unknown: "Unknown error"
        }
    }
}

extension DatabaseError {
    public init(_ error: Error?) {
        switch error {
        case .none:
            self = .unknown
        case .some(let error):
            self = .underlying(error)
        }
    }
}
