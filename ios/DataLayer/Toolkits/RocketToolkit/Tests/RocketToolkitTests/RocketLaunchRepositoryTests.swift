//
//  Created by Petr Chmelar on 24.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Apollo
import ApolloAPI
import ApolloTestSupport
import GraphQLProvider
import GraphQLProviderMocks
@testable import RocketToolkit
import RocketToolkitMocks
import SharedDomain
import SharedDomainMocks
import XCTest

final class RocketLaunchRepositoryTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let graphQLProvider = GraphQLProviderMock<Rocket.RocketLaunchListQuery>()

    private func createRepository() -> RocketLaunchRepository {
        RocketLaunchRepositoryImpl(graphQLProvider: graphQLProvider)
    }
    
    // MARK: Tests
    
    func testList() async throws {
        let repository = createRepository()
        let queryData = Rocket.RocketLaunchListQuery.Data.from(Mock<Query>(
            launches: Mock<LaunchConnection>(
                launches: [RocketLaunch].stub.map { Mock<Launch>(id: $0.id, site: $0.site) }
            )
        ))
        let queryResult = GraphQLResult(data: queryData, extensions: nil, errors: nil, source: .server, dependentKeys: nil)
        graphQLProvider.fetchReturnValues = [queryResult]

        let rocketLaunchesStream = repository.list()

        for try await rocketLaunches in rocketLaunchesStream {
            XCTAssertEqual(rocketLaunches, [RocketLaunch].stub)
            break
        }
        XCTAssertEqual(graphQLProvider.fetchCallsCount, 1)
    }
}
