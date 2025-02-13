//
//  NetworkInterceptorsProvider.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import Apollo
import ApolloAPI

final class NetworkInterceptorsProvider: DefaultInterceptorProvider {
    private let interceptors: [ApolloInterceptor]
    
    init(interceptors: [ApolloInterceptor], store: ApolloStore) {
        self.interceptors = interceptors
        super.init(store: store)
    }
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        self.interceptors.forEach { interceptor in
            interceptors.insert(interceptor, at: 0)
        }
        return interceptors
    }
}
