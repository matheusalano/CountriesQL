import Foundation

final class AppCoordinator: BaseCoordinator {
    
    override func start(onFinish: (() -> ())? = nil) {
        let continentCoordinator = ContinentListCoordinator(router: router)
        store(coordinator: continentCoordinator)
        
        continentCoordinator.start { [weak self] in
            self?.free(coordinator: continentCoordinator)
        }
    }
}
