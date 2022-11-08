// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI
@_exported import enum ApolloAPI.GraphQLEnum
@_exported import enum ApolloAPI.GraphQLNullable

public extension Rocket {
  class RocketLaunchListQuery: GraphQLQuery {
    public static let operationName: String = "RocketLaunchList"
    public static let document: DocumentType = .notPersisted(
      definition: .init(
        """
        query RocketLaunchList {
          launches {
            __typename
            cursor
            hasMore
            launches {
              __typename
              id
              site
            }
          }
        }
        """
      ))

    public init() {}

    public struct Data: Rocket.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { Rocket.Objects.Query }
      public static var __selections: [Selection] { [
        .field("launches", Launches.self),
      ] }

      public var launches: Launches { __data["launches"] }

      /// Launches
      ///
      /// Parent Type: `LaunchConnection`
      public struct Launches: Rocket.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { Rocket.Objects.LaunchConnection }
        public static var __selections: [Selection] { [
          .field("cursor", String.self),
          .field("hasMore", Bool.self),
          .field("launches", [Launch?].self),
        ] }

        public var cursor: String { __data["cursor"] }
        public var hasMore: Bool { __data["hasMore"] }
        public var launches: [Launch?] { __data["launches"] }

        /// Launches.Launch
        ///
        /// Parent Type: `Launch`
        public struct Launch: Rocket.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ParentType { Rocket.Objects.Launch }
          public static var __selections: [Selection] { [
            .field("id", ID.self),
            .field("site", String?.self),
          ] }

          public var id: ID { __data["id"] }
          public var site: String? { __data["site"] }
        }
      }
    }
  }

}