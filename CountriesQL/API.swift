// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CountryListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CountryList($continentID: String) {
      countries(filter: {continent: {eq: $continentID}}) {
        __typename
        code
        name
        native
        emoji
      }
    }
    """

  public let operationName: String = "CountryList"

  public var continentID: String?

  public init(continentID: String? = nil) {
    self.continentID = continentID
  }

  public var variables: GraphQLMap? {
    return ["continentID": continentID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("countries", arguments: ["filter": ["continent": ["eq": GraphQLVariable("continentID")]]], type: .nonNull(.list(.nonNull(.object(Country.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(countries: [Country]) {
      self.init(unsafeResultMap: ["__typename": "Query", "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }])
    }

    public var countries: [Country] {
      get {
        return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
      }
    }

    public struct Country: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Country"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("native", type: .nonNull(.scalar(String.self))),
          GraphQLField("emoji", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: GraphQLID, name: String, native: String, emoji: String) {
        self.init(unsafeResultMap: ["__typename": "Country", "code": code, "name": name, "native": native, "emoji": emoji])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: GraphQLID {
        get {
          return resultMap["code"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var native: String {
        get {
          return resultMap["native"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "native")
        }
      }

      public var emoji: String {
        get {
          return resultMap["emoji"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "emoji")
        }
      }
    }
  }
}

public final class ContinentListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ContinentList {
      continents {
        __typename
        code
        name
        countries {
          __typename
          code
        }
      }
    }
    """

  public let operationName: String = "ContinentList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("continents", type: .nonNull(.list(.nonNull(.object(Continent.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(continents: [Continent]) {
      self.init(unsafeResultMap: ["__typename": "Query", "continents": continents.map { (value: Continent) -> ResultMap in value.resultMap }])
    }

    public var continents: [Continent] {
      get {
        return (resultMap["continents"] as! [ResultMap]).map { (value: ResultMap) -> Continent in Continent(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Continent) -> ResultMap in value.resultMap }, forKey: "continents")
      }
    }

    public struct Continent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Continent"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("countries", type: .nonNull(.list(.nonNull(.object(Country.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: GraphQLID, name: String, countries: [Country]) {
        self.init(unsafeResultMap: ["__typename": "Continent", "code": code, "name": name, "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: GraphQLID {
        get {
          return resultMap["code"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var countries: [Country] {
        get {
          return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
        }
      }

      public struct Country: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Country"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "Country", "code": code])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: GraphQLID {
          get {
            return resultMap["code"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }
      }
    }
  }
}
