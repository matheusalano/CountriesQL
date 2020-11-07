import Foundation

@testable import CountriesQL

extension CountryListQuery.Data.Country: Equatable {
    public static func == (lhs: CountryListQuery.Data.Country, rhs: CountryListQuery.Data.Country) -> Bool {
        lhs.code == rhs.code &&
        lhs.name == rhs.name &&
        lhs.native == rhs.native &&
        lhs.emoji == rhs.emoji
    }
    
    static let dummy = CountryListQuery.Data.Country(code: "123", name: "name", native: "native", emoji: "emoji")
}


