//
//  Created by Petr Chmelar on 08.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

// swiftlint:disable all

import Apollo
import ApolloAPI
import Foundation
import GraphQLProvider

public final class GraphQLProviderMock<Query: GraphQLQuery>: GraphQLProvider {

    public init() {}

    // MARK: - fetch<Query: GraphQLQuery>

    public var fetchCallsCount = 0
    public var fetchCalled: Bool {
        return fetchCallsCount > 0
    }
    public var fetchReturnValues: [GraphQLResult<Query.Data>] = []

    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        contextIdentifier: UUID?,
        queue: DispatchQueue
    ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error> {
        fetchCallsCount += 1
        return AsyncThrowingStream(GraphQLResult<Query.Data>.self) { continuation in
            fetchReturnValues.forEach { returnValue in
                guard let typedReturnValue = returnValue as? GraphQLResult<Query.Data> else { return }
                continuation.yield(typedReturnValue)
            }
            continuation.finish()
        }
    }

}
