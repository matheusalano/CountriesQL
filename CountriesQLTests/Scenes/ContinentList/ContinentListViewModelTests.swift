import XCTest

@testable import CountriesQL

final class ContinentListViewModelTests: XCTestCase {

    private var service: ContinentListServiceMock!
    private var delegate: ViewModelDelegateMock!
    private var coordinatorDelegate: CoordinatorDelegateMock!
    private var sut: ContinentListViewModel!
    
    func setup(result: Result<[ContinentListServiceProtocol.Continent], NetworkError>) {
        service = ContinentListServiceMock(result: result)
        delegate = ViewModelDelegateMock()
        coordinatorDelegate = CoordinatorDelegateMock()
        sut = ContinentListViewModel(service: service)
        sut.delegate = delegate
        sut.coordinatorDelegate = coordinatorDelegate
    }
    
    func testDataRequested() {
        setup(result: .failure(.generic))
        sut.requestData()
        
        XCTAssertEqual(service.getContinentsCounter, 1)
    }
    
    func testFailure() {
        setup(result: .failure(.generic))
        sut.requestData()
        
        XCTAssertTrue(sut.continents.isEmpty)
        XCTAssertEqual(delegate.setLoadingCalled, [true, false])
        XCTAssertEqual(delegate.showErrorCalled, ["Oops! Something went wrong!"])
        XCTAssertEqual(delegate.reloadTableCounter, 1)
    }
    
    func testSuccess() {
        setup(result: .success([.dummy]))
        sut.requestData()
        
        XCTAssertEqual(sut.continents, [.dummy])
        XCTAssertEqual(delegate.setLoadingCalled, [true, false])
        XCTAssertEqual(delegate.showErrorCalled, [])
        XCTAssertEqual(delegate.reloadTableCounter, 1)
    }
    
    func testRowSelected() {
        setup(result: .success([.dummy]))
        sut.requestData()
        sut.rowSelected(IndexPath(row: 0, section:  0))
        
        XCTAssertEqual(coordinatorDelegate.startCountryCalled, ["123"])
    }
}

private final class ContinentListServiceMock: ContinentListServiceProtocol {
    
    var getContinentsCounter = 0
    
    let result: Result<[Continent], NetworkError>
    
    init(result: Result<[Continent], NetworkError>) {
        self.result = result
    }
    
    func getContinents(completion: @escaping ((Result<[Continent], NetworkError>) -> Void)) {
        getContinentsCounter += 1
        
        completion(result)
    }
}

private final class ViewModelDelegateMock: ContinentListViewModelDelegate {
    
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

private final class CoordinatorDelegateMock: ContinentListCoordinatorDelegate {
    
    var startCountryCalled: [String] = []
    
    func startCountryListScene(continentID: String) {
        startCountryCalled.append(continentID)
    }
}
