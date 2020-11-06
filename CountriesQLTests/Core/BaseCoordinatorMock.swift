import Foundation

@testable import CountriesQL

final class BaseCoordinatorMock: BaseCoordinator {
    
    var startCounter = 0
    
    init() {
        super.init(router: AppRouterMock())
    }
    
    override func start(onFinish: (() -> ())? = nil) {
        startCounter += 1
        
        onFinish?()
    }
}
