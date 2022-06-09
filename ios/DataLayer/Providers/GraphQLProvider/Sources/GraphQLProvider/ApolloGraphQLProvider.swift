//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Apollo
import Foundation

public struct ApolloGraphQLProvider {
    
    private let apollo: ApolloClient

    public init(baseURL: String) {
        apollo = ApolloClient(url: URL(string: baseURL)!)
    }
}

extension ApolloGraphQLProvider: GraphQLProvider {
    public func fetch<Query: GraphQLQuery>(
      query: Query,
      cachePolicy: CachePolicy,
      contextIdentifier: UUID?,
      queue: DispatchQueue
    ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error> {
        apollo.fetch(
            query: query,
            cachePolicy: cachePolicy,
            contextIdentifier: contextIdentifier,
            queue: queue
        )
    }
}
