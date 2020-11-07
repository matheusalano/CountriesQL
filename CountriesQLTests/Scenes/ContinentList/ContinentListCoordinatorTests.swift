import XCTest

@testable import CountriesQL

final class ContinentListCoordinatorTests: XCTestCase {
    
    private var router = AppRouterMock()
    private var countryCoordinator = BaseCoordinatorMock()
    private var viewModel: ContinentListViewModelMock!
    private var sut: ContinentListCoordinator!
    
    override func setUpWithError() throws {
        viewModel = ContinentListViewModelMock()
        sut = ContinentListCoordinator(router: router, viewModel: viewModel, countryCoordinator: countryCoordinator)
    }
    
    func testStart() {
        sut.start(onFinish: {})
        
        XCTAssertTrue(viewModel.coordinatorDelegate === sut)
        XCTAssertTrue(router.viewController is ContinentListViewController)
        XCTAssertTrue(router.isAnimated!)
        XCTAssertTrue(router.onNavigateBack != nil)
    }
    
    func testCountryCoordinator() {
        sut.start(onFinish: {})
        viewModel.rowSelected(IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(countryCoordinator.startCounter, 1)
    }
}

private final class ContinentListViewModelMock: ContinentListViewModelProtocol {
    
    var delegate: ContinentListViewModelDelegate?
    
    var coordinatorDelegate: ContinentListCoordinatorDelegate?
    
    var continents: [Continent] = []
    
    func requestData() {}
    
    func rowSelected(_ indexPath: IndexPath) {
        coordinatorDelegate?.startCountryListScene(continent: .dummy)
    }
}
