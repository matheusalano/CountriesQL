import XCTest

@testable import CountriesQL

final class CountryListCoordinatorTests: XCTestCase {
    
    private var router = AppRouterMock()
    private var viewModel: CountryListViewModelMock!
    private var sut: CountryListCoordinator!
    
    override func setUpWithError() throws {
        viewModel = CountryListViewModelMock()
        sut = CountryListCoordinator(router: router, viewModel: viewModel)
    }
    
    func testStart() {
        sut.start(onFinish: {})
        
        XCTAssertTrue(router.viewController is CountryListViewController)
        XCTAssertTrue(router.isAnimated!)
        XCTAssertTrue(router.onNavigateBack != nil)
    }
}

private final class CountryListViewModelMock: CountryListViewModelProtocol {
    
    var delegate: CountryListViewModelDelegate?
    
    var countries: [Country] = []
    
    var continentName = ""
    
    func requestData() {}
}
