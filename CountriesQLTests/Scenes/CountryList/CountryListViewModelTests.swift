import XCTest

@testable import CountriesQL

final class CountryListViewModelTests: XCTestCase {

    private var service: CountryListServiceMock!
    private var delegate: ViewModelDelegateMock!
    private var sut: CountryListViewModel!
    
    func setup(result: Result<[CountryListServiceProtocol.Country], NetworkError>) {
        service = CountryListServiceMock(result: result)
        delegate = ViewModelDelegateMock()
        sut = CountryListViewModel(continent: .dummy, service: service)
        sut.delegate = delegate
    }
    
    func testDataRequested() {
        setup(result: .failure(.generic))
        sut.requestData()
        
        XCTAssertEqual(service.getCountriesCalled, ["123"])
    }
    
    func testFailure() {
        setup(result: .failure(.generic))
        sut.requestData()
        
        XCTAssertTrue(sut.countries.isEmpty)
        XCTAssertEqual(delegate.setLoadingCalled, [true, false])
        XCTAssertEqual(delegate.showErrorCalled, ["Oops! Something went wrong!"])
        XCTAssertEqual(delegate.reloadTableCounter, 1)
    }
    
    func testSuccess() {
        setup(result: .success([.dummy]))
        sut.requestData()
        
        XCTAssertEqual(sut.countries, [.dummy])
        XCTAssertEqual(delegate.setLoadingCalled, [true, false])
        XCTAssertEqual(delegate.showErrorCalled, [])
        XCTAssertEqual(delegate.reloadTableCounter, 1)
    }
}

private final class CountryListServiceMock: CountryListServiceProtocol {
    
    var getCountriesCalled: [String] = []
    
    let result: Result<[Country], NetworkError>
    
    init(result: Result<[Country], NetworkError>) {
        self.result = result
    }
    
    func getCountries(continentID: String, completion: @escaping ((Result<[Country], NetworkError>) -> Void)) {
        getCountriesCalled.append(continentID)
        
        completion(result)
    }
}

private final class ViewModelDelegateMock: CountryListViewModelDelegate {
    
    var setLoadingCalled: [Bool] = []
    var reloadTableCounter = 0
    var showErrorCalled: [String] = []
    
    func setLoading(_ loading: Bool) {
        setLoadingCalled.append(loading)
    }
    
    func reloadTable() {
        reloadTableCounter += 1
    }
    
    func showError(message: String) {
        showErrorCalled.append(message)
    }
}
