import Foundation

final class CountryListCoordinator: BaseCoordinator {
    
    let viewModel: CountryListViewModelProtocol
    
    init(router: AppRouterProtocol, continent: ContinentListQuery.Data.Continent) {
        viewModel = CountryListViewModel(continent: continent)
        super.init(router: router)
    }
    
    init(router: AppRouterProtocol, viewModel: CountryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(router: router)
    }
    
    override func start(onFinish: (() -> ())? = nil) {
        let viewController = CountryListViewController(viewModel: viewModel)
        
        router.push(viewController, isAnimated: true, onNavigateBack: onFinish)
    }
}
