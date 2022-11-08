// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RocketToolkit

public class Launch: MockObject {
  public static let objectType: Object = Rocket.Objects.Launch
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Launch>>

  public struct MockFields {
    @Field<Rocket.ID>("id") public var id
    @Field<String>("site") public var site
  }
}

public extension Mock where O == Launch {
  convenience init(
    id: Rocket.ID? = nil,
    site: String? = nil
  ) {
    self.init()
    self.id = id
    self.site = site
  }
}
