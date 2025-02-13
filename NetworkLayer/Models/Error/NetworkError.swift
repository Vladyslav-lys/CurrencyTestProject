//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import Foundation

// MARK: - NetworkError
public enum NetworkError: Error {
    case sessionRequired
    case noApiKey
    case noData
    case underlying(Error)
    case decoding(DecodingError, URL?)
    case api(APIError)
    case unknown
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .sessionRequired: "Session is required"
        case .noApiKey: "API-Key is required"
        case .noData: "No data in response"
        case .underlying(let error): error.localizedDescription
        case .api(let error): error.message
        case let .decoding(error, url): handleDecodingError(error, url: url)
        case .unknown: "Unknown error"
        }
    }
    
    private func handleDecodingError(_ error: DecodingError, url: URL?) -> String {
        var errorMessage = ""
        switch error {
        case .dataCorrupted(let context):
            errorMessage = "\(error.debugDescription)\n\(context.debugDescription)\n\(context.codingPath)"
        case let .keyNotFound(key, context):
            errorMessage = "\(error.debugDescription)\n\(key.description)\n\(context.debugDescription)\n\(context.codingPath)"
        case let .typeMismatch(type, context):
            errorMessage = "\(error.debugDescription)\n\(type)\n\(context.debugDescription)\n\(context.codingPath)"
        case let .valueNotFound(type, context):
            errorMessage = "\(error.debugDescription)\n\(type)\n\(context.debugDescription)\n\(context.codingPath)"
        @unknown default:
            errorMessage = "\(error.debugDescription)"
        }
        url.flatMap { errorMessage += "\nurl: \($0.absoluteString)" }
        return errorMessage
    }
}

extension NetworkError {
    public init(_ error: Error?) {
        switch error {
        case let apiError as APIError:
            self = .api(apiError)
        case let decodingError as DecodingError:
            self = .decoding(decodingError, nil)
        case .none:
            self = .unknown
        case .some(let error):
            self = .underlying(error)
        }
    }
}
