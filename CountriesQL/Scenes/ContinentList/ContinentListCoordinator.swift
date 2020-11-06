import Foundation

final class ContinentListCoordinator: BaseCoordinator {
    
    private var viewModel: ContinentListViewModelProtocol
    private var countryCoordinator: BaseCoordinator?
    
    override init(router: AppRouterProtocol) {
        viewModel = ContinentListViewModel()
        super.init(router: router)
    }
    
    init(router: AppRouterProtocol, viewModel: ContinentListViewModelProtocol, countryCoordinator: BaseCoordinator) {
        self.viewModel = viewModel
        self.countryCoordinator = countryCoordinator
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
        let countryCoordinator = self.countryCoordinator ?? CountryListCoordinator(router: router, continent: continent)
        store(coordinator: countryCoordinator)
        
        countryCoordinator.start { [weak self] in
            self?.free(coordinator: countryCoordinator)
        }
    }
}
