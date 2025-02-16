//
//  UseCasesConsumer.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 15.02.2025.
//

import Foundation

protocol UseCasesConsumer: AnyObject {
    associatedtype UseCases
    
    var useCases: UseCases { get set }
}
