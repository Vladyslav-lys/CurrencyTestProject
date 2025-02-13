//
//  DecodingError+Debug.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import Foundation

extension DecodingError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .dataCorrupted(let context): "Data corrupted @ \(context.keyPath)"
        default: "Unknown error"
        }
    }
}

private extension DecodingError.Context {
    var keyPath: String {
        codingPath.map { $0.keyPath }.joined(separator: ".")
    }
}

private extension CodingKey {
    var keyPath: String {
        intValue.flatMap(String.init) ?? stringValue
    }
}
