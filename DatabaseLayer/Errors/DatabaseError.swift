//
//  DatabaseError.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import Foundation

enum DatabaseError: Error {
    case notFound
    case underlying(Error)
}
