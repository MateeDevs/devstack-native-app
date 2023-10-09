//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Apollo
import ApolloAPI
import Foundation

// Extension which adds async/await support to Apollo
// Taken from: https://github.com/apollographql/apollo-ios/issues/2216

// Official support should be ready in version 2.0
// https://github.com/apollographql/apollo-ios/blob/main/ROADMAP.md

public extension ApolloClient {
    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .default,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error> {
        AsyncThrowingStream { continuation in
            let request = fetch(
                query: query,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                queue: queue
            ) { response in
                switch response {
                case .success(let result):
                    continuation.yield(result)
                    if result.isFinalForCachePolicy(cachePolicy) {
                        continuation.finish()
                    }
                case .failure(let error):
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { @Sendable _ in request.cancel() }
        }
    }
}

extension GraphQLResult {
    func isFinalForCachePolicy(_ cachePolicy: CachePolicy) -> Bool {
        switch cachePolicy {
        case .returnCacheDataElseFetch: true
        case .fetchIgnoringCacheData: source == .server
        case .fetchIgnoringCacheCompletely: source == .server
        case .returnCacheDataDontFetch: source == .cache
        case .returnCacheDataAndFetch: source == .server
        }
    }
}
