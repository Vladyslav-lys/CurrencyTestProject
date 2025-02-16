//
//  With.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import Foundation

@discardableResult
func with<T>(_ value: T, _ builder: (inout T) throws -> Void) rethrows -> T {
    var mutableValue = value
    try builder(&mutableValue)
    return mutableValue
}
