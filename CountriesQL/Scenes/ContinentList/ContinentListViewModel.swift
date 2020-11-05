import Foundation

protocol ContinentListViewModelDelegate: class {
    func setLoading(_ loading: Bool)
    func reloadTable()
    func showError(message: String)
}

protocol ContinentListCoordinatorDelegate: class {
    func startCountryListScene(continentID: String)
}

protocol ContinentListViewModelProtocol {
    typealias Continent = ContinentListQuery.Data.Continent
    
    var delegate: ContinentListViewModelDelegate? { get set }
    var coordinatorDelegate: ContinentListCoordinatorDelegate? { get set }
    var continents: [Continent] { get }
    
    func requestData()
    func rowSelected(_ indexPath: IndexPath)
}

final class ContinentListViewModel: ContinentListViewModelProtocol {
    
    weak var delegate: ContinentListViewModelDelegate?
    weak var coordinatorDelegate: ContinentListCoordinatorDelegate?
    
    private(set) var continents: [Continent] = []
    
    let service: ContinentListServiceProtocol
    
    init(service: ContinentListServiceProtocol = ContinentListService()) {
        self.service = service
    }
    
    func requestData() {
        delegate?.setLoading(true)
        
        service.getContinents { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let continents):
                self.continents = continents
                self.delegate?.setLoading(false)
                self.delegate?.reloadTable()
            case .failure(let error):
                self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func rowSelected(_ indexPath: IndexPath) {
        coordinatorDelegate?.startCountryListScene(continentID: continents[indexPath.row].code)
    }
}
