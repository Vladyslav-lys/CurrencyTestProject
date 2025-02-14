//
//  ServiceContext.swift
//  Services
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import DatabaseLayer
import NetworkLayer

final class ServiceContext {
    let network: Network
    let database: CDDatabase

    init(network: Network, database: CDDatabase) {
        self.network = network
        self.database = database
    }
}
