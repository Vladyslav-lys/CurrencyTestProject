//
//  ApiKeyIncerceptor.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 13.02.2025.
//

import Apollo
import ApolloAPI

public final class ApiKeyIncerceptor: ApolloInterceptor {
    public var id: String
    private var apiKey: String?
    
    public init(id: String = UUID().uuidString) {
        self.id = id
    }
    
    public func setApiKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
            guard let apiKey else {
                completion(.failure(NetworkError.noApiKey))
                return
            }
            request.addHeader(name: "Authorization", value: "ApiKey \(apiKey)")
            chain.proceedAsync(request: request, response: response, interceptor: self, completion: completion)
    }
}
