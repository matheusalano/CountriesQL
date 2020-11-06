import Foundation

final class ContinentListCoordinator: BaseCoordinator {
    
    private var viewModel: ContinentListViewModelProtocol
    
    override init(router: AppRouterProtocol) {
        viewModel = ContinentListViewModel()
        super.init(router: router)
    }
    
    init(router: AppRouterProtocol, viewModel: ContinentListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(router: router)
    }
    
    override func start(onFinish: (() -> ())? = nil) {
        viewModel.coordinatorDelegate = self
        let viewController = ContinentListViewController(viewModel: viewModel)
        
        router.push(viewController, isAnimated: true, onNavigateBack: onFinish)
    }
}

extension ContinentListCoordinator: ContinentListCoordinatorDelegate {
    func startCountryListScene(continent: ContinentListQuery.Data.Continent) {
        let countryCoordinator = CountryListCoordinator(router: router, continent: continent)
        store(coordinator: countryCoordinator)
        
        countryCoordinator.start { [weak self] in
            self?.free(coordinator: countryCoordinator)
        }
    }
}
