import Foundation

@testable import CountriesQL

extension ContinentListQuery.Data.Continent.Country: Equatable {
    public static func == (lhs: ContinentListQuery.Data.Continent.Country, rhs: ContinentListQuery.Data.Continent.Country) -> Bool {
        lhs.code == rhs.code
    }
}

extension ContinentListQuery.Data.Continent: Equatable {
    public static func == (lhs: ContinentListQuery.Data.Continent, rhs: ContinentListQuery.Data.Continent) -> Bool {
        lhs.code == rhs.code &&
        lhs.name == rhs.name &&
        lhs.countries == rhs.countries
    }
    
    
    static let dummy = ContinentListQuery.Data.Continent(code: "123", name: "Dummy", countries: [])
}
