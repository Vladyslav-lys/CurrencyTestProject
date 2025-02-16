//
//  ServiceContext.swift
//  Services
//
//  Created by Vladyslav Lysenko on 14.02.2025.
//

import DatabaseLayer
import NetworkLayer

public final class ServiceContext {
    let network: Network
    let database: CDDatabase

    public init(network: Network, database: CDDatabase) {
        self.network = network
        self.database = database
    }
}
