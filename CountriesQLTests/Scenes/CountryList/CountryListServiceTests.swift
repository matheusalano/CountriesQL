import XCTest
import Apollo

@testable import CountriesQL

final class CountryListServiceTests: XCTestCase {
    
    private var networkMock: NetworkTransportMock<CountryListQuery.Data>!
    private var client: ApolloClient!
    private var sut: CountryListService!

    func setup(result: Result<CountryListQuery.Data, Error>) {
        networkMock = NetworkTransportMock(result: result)
        client = ApolloClient(networkTransport: networkMock, store: ApolloStore())
        sut = CountryListService(client: client)
    }

    func testSuccess() throws {
        let truth = CountryListQuery.Data(countries: [.dummy])
        setup(result: .success(truth))
        
        let expectation = self.expectation(description: "Fetching query")
        
        sut.getCountries(continentID: "") { result in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(let data):
                XCTAssertEqual(data, truth.countries)
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGenericFailure() throws {
        setup(result: .failure(NetworkError.generic))
        
        let expectation = self.expectation(description: "Fetching query")
        
        sut.getCountries(continentID: "") { result in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .generic)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInternetFailure() throws {
        setup(result: .failure(URLSessionClient.URLSessionClientError.networkError(data: Data(), response: nil, underlying: NetworkError.generic)))
        
        let expectation = self.expectation(description: "Fetching query")
        
        sut.getCountries(continentID: "") { result in
            defer { expectation.fulfill() }
            
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noConnection)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
