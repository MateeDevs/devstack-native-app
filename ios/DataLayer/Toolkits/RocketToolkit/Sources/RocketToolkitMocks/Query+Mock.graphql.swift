// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RocketToolkit

public class Query: MockObject {
  public static let objectType: Object = Rocket.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<LaunchConnection>("launches") public var launches
  }
}

public extension Mock where O == Query {
  convenience init(
    launches: Mock<LaunchConnection>? = nil
  ) {
    self.init()
    self.launches = launches
  }
}
