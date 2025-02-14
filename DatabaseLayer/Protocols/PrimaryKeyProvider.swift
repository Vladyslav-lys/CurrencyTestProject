//
//  PrimaryKeyProvider.swift
//  DatabaseLayer
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import Foundation

protocol PrimaryKeyProvider {
    static var primaryKey: String { get }
}
