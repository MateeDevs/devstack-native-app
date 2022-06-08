//
//  Created by Petr Chmelar on 24.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Apollo
import GraphQLProvider
import GraphQLProviderMocks
@testable import RocketToolkit
import SharedDomain
import SharedDomainMocks
import XCTest

final class RocketLaunchRepositoryTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let graphQLProvider = GraphQLProviderMock<RocketLaunchListQuery>()

    private func createRepository() -> RocketLaunchRepository {
        RocketLaunchRepositoryImpl(graphQLProvider: graphQLProvider)
    }
    
    // MARK: Tests
    
    func testRead() async throws {
        let repository = createRepository()
        let rocketLaunches = [RocketLaunch].stub.map { $0.networkModel }
        let queryData = RocketLaunchListQuery.Data(launches: .init(cursor: "0", hasMore: true, launches: rocketLaunches))
        let queryResult = GraphQLResult(data: queryData, extensions: nil, errors: nil, source: .server, dependentKeys: nil)
        graphQLProvider.fetchReturnValues = [queryResult]

        let rocketLaunchesStream = repository.read()

        for try await rocketLaunches in rocketLaunchesStream {
            XCTAssertEqual(rocketLaunches, [RocketLaunch].stub)
            break
        }
        XCTAssertEqual(graphQLProvider.fetchCallsCount, 1)
    }
}
