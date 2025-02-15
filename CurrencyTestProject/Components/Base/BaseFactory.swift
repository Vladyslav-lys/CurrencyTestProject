//
//  BaseFactory.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import UIKit

class BaseFactory {
    private(set) weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Make
extension BaseFactory {
    func makeController<T: Makeable>(_ builder: T.Builder) -> T
        where T.Value == T, T: UIViewController {
        let controller: T = T.make(builder)
        return controller
    }
}
