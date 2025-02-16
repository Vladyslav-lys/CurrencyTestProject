// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LatestRatesQuery: GraphQLQuery {
  public static let operationName: String = "LatestRates"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query LatestRates { latest { __typename date baseCurrency quoteCurrency quote } }"#
    ))

  public init() {}

  public struct Data: RatesAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { RatesAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("latest", [Latest].self),
    ] }

    /// Returns the latest rates
    public var latest: [Latest] { __data["latest"] }

    /// Latest
    ///
    /// Parent Type: `Rate`
    public struct Latest: RatesAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { RatesAPI.Objects.Rate }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("date", RatesAPI.Date.self),
        .field("baseCurrency", String.self),
        .field("quoteCurrency", String.self),
        .field("quote", RatesAPI.BigDecimal.self),
      ] }

      public var date: RatesAPI.Date { __data["date"] }
      public var baseCurrency: String { __data["baseCurrency"] }
      public var quoteCurrency: String { __data["quoteCurrency"] }
      public var quote: RatesAPI.BigDecimal { __data["quote"] }
    }
  }
}
