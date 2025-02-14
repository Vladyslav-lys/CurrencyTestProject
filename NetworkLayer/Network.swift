//
//  Network.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import Apollo
import ApolloAPI
import Network
import Combine

final public class Network {
    // MARK: - Private properties
    private let baseURL: URL
    private let connectionMonitor = NWPathMonitor()
    private let store = ApolloStore()
    private let interceptorProvider: InterceptorProvider
    private let networkTransport: NetworkTransport
    
    // MARK: - Internal properties
    let apollo: ApolloClient
    
    // MARK: - Public properties
    public var isConnected = CurrentValueSubject<Bool, Never>(false)
    
    // MARK: - Initialize
    public init(baseURL: URL, interceptors: [ApolloInterceptor]) {
        self.baseURL = baseURL
        interceptorProvider = NetworkInterceptorsProvider(interceptors: interceptors, store: store)
        networkTransport = RequestChainNetworkTransport(interceptorProvider: interceptorProvider, endpointURL: baseURL)
        apollo = ApolloClient(networkTransport: networkTransport, store: store)
        setupNetworkCheck()
    }
    
    // MARK: - Setup
    private func setupNetworkCheck() {
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        connectionMonitor.start(queue: queue)
        connectionMonitor.pathUpdateHandler = { [isConnected] path in
            guard isConnected.value != (path.status == .satisfied) else { return }
            isConnected.value = path.status == .satisfied
        }
    }
    
    // MARK: - Async
    @discardableResult
    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .default,
        contextIdentifier: UUID? = nil,
        context: (any RequestContext)? = nil,
        queue: DispatchQueue = .main
    ) async throws -> Query.Data {
        try await withUnsafeThrowingContinuation { [weak self] continuation in
            self?.apollo.fetch(
                query: query,
                cachePolicy: cachePolicy,
                context: context,
                queue: queue
            ) { result in
                switch result {
                case .success(let value):
                    if let errors = value.errors,
                       let jsonError = errors.first?["message"] as? String {
                        continuation.resume(throwing: NetworkError.api(APIError(message: jsonError)))
                    } else if let data = value.data {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: NetworkError.noData)
                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError(error))
                }
            }
        }
    }
}
