import UIKit

@testable import CountriesQL

final class AppRouterMock: AppRouterProtocol {
    
    var viewController: UIViewController?
    var isAnimated: Bool?
    var onNavigateBack: NavigationBackClosure?
    
    func push(_ viewController: UIViewController, isAnimated: Bool, onNavigateBack: NavigationBackClosure?) {
        self.viewController = viewController
        self.isAnimated = isAnimated
        self.onNavigateBack = onNavigateBack
    }
}
