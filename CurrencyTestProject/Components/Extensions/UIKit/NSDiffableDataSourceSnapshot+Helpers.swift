//
//  NSDiffableDataSourceSnapshot+Helpers.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 17.02.2025.
//

import UIKit

extension NSDiffableDataSourceSnapshot {
    mutating func update(_ item: ItemIdentifierType, to newItem: ItemIdentifierType) {
        insertItems([newItem], beforeItem: item)
        deleteItems([item])
    }
}
