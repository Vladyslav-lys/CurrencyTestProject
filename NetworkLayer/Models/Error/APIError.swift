//
//  APIError.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import Foundation

public struct APIError: Decodable, LocalizedError {
    let message: String
}

extension APIError {
    public init(_ response: Response) {
        message = response.message
    }
}

extension APIError {
    public struct Response: Decodable {
        let message: String
    }
}
