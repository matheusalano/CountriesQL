import Foundation

protocol CountryListViewModelDelegate: class {
    func setLoading(_ loading: Bool)
    func reloadTable()
    func showError(message: String)
}

protocol CountryListViewModelProtocol {
    typealias Country = CountryListQuery.Data.Country
    
    var delegate: CountryListViewModelDelegate? { get set }
    var countries: [Country] { get }
    var continentName: String { get }
    
    func requestData()
}

final class CountryListViewModel: CountryListViewModelProtocol {
    
    weak var delegate: CountryListViewModelDelegate?
    
    private(set) var countries: [Country] = []
    
    private let continentID: String
    let continentName: String
    
    let service: CountryListServiceProtocol
    
    init(continent: ContinentListQuery.Data.Continent, service: CountryListServiceProtocol = CountryListService()) {
        continentID = continent.code
        continentName = continent.name
        self.service = service
    }
    
    func requestData() {
        delegate?.setLoading(true)
        
        service.getCountries(continentID: continentID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let countries):
                self.countries = countries
            case .failure(let error):
                self.countries = []
                self.delegate?.showError(message: error.readableMessage)
            }
            
            self.delegate?.setLoading(false)
            self.delegate?.reloadTable()
        }
    }
}
