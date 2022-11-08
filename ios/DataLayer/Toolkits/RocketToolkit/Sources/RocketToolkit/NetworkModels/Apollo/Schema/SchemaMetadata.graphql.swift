// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol Rocket_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == Rocket.SchemaMetadata {}

public protocol Rocket_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == Rocket.SchemaMetadata {}

public protocol Rocket_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == Rocket.SchemaMetadata {}

public protocol Rocket_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == Rocket.SchemaMetadata {}

public extension Rocket {
  typealias ID = String

  typealias SelectionSet = Rocket_SelectionSet

  typealias InlineFragment = Rocket_InlineFragment

  typealias MutableSelectionSet = Rocket_MutableSelectionSet

  typealias MutableInlineFragment = Rocket_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return Rocket.Objects.Query
      case "LaunchConnection": return Rocket.Objects.LaunchConnection
      case "Launch": return Rocket.Objects.Launch
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}