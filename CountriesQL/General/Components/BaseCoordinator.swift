import Foundation

class BaseCoordinator {
    
    private let identifier = UUID()

    private var childCoordinators = [UUID: BaseCoordinator]()
    
    let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
    }

    func start() {
        fatalError("Children should implement `start`.")
    }
    
    final func store(coordinator: BaseCoordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    final func free(coordinator: BaseCoordinator) {
        childCoordinators[coordinator.identifier] = nil
    }
}
