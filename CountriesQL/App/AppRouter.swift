//Kindly imported from https://benoitpasquier.com/coordinator-pattern-navigation-back-button-swift/

import UIKit

protocol AppRouterProtocol: class {
    typealias NavigationBackClosure = (() -> ())
    
    func push(_ viewController: UIViewController, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
}

final class AppRouter : NSObject, AppRouterProtocol {

    let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    func push(_ viewController: UIViewController, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension AppRouter : UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
}
