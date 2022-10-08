//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import GraphQLProvider
import SharedDomain

public struct RocketLaunchRepositoryImpl: RocketLaunchRepository {
    
    private let graphQL: GraphQLProvider
    
    public init(graphQLProvider: GraphQLProvider) {
        self.graphQL = graphQLProvider
    }
    
    public func list() -> AsyncThrowingStream<[RocketLaunch], Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    for try await result in graphQL.fetch(query: Rocket.RocketLaunchListQuery()) {
                        guard let data = result.data else { return }
                        continuation.yield(data.launches.launches.compactMap { $0?.domainModel })
                    }
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
