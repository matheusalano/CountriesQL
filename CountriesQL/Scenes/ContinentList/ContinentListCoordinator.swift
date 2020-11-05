import Foundation

final class ContinentListCoordinator: BaseCoordinator {
    
    let viewModel: ContinentListViewModelProtocol
    
    override init(router: AppRouterProtocol) {
        viewModel = ContinentListViewModel()
        super.init(router: router)
    }
    
    init(router: AppRouterProtocol, viewModel: ContinentListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(router: router)
    }
    
    override func start(onFinish: (() -> ())? = nil) {
        let viewController = ContinentListViewController(viewModel: viewModel)
        
        router.push(viewController, isAnimated: true, onNavigateBack: onFinish)
    }
}
