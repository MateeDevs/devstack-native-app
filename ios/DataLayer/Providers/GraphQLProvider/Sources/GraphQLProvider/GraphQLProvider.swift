//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Apollo
import ApolloAPI
import Foundation

public protocol GraphQLProvider {

    /// Function for fetching a given GraphQL query.
    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        contextIdentifier: UUID?,
        queue: DispatchQueue
    ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error>
}

// This extension exists only to provide default values for parameters
public extension GraphQLProvider {
    func fetch<Query: GraphQLQuery>(
      query: Query,
      cachePolicy: CachePolicy = .default,
      contextIdentifier: UUID? = nil,
      queue: DispatchQueue = .main
    ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error> {
        fetch(query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, queue: queue)
    }
}
