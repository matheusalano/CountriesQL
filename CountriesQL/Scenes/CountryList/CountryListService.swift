import Foundation
import Apollo

protocol CountryListServiceProtocol {
    typealias Country = CountryListQuery.Data.Country
    
    func getCountries(continentID: String, completion: @escaping ((Result<[Country], NetworkError>) -> Void))
}

final class CountryListService: CountryListServiceProtocol {
    let client: ApolloClient

    init(client: ApolloClient = Network.shared.apollo) {
        self.client = client
    }

    func getCountries(continentID: String, completion: @escaping ((Result<[Country], NetworkError>) -> Void)) {
        client.fetch(query: CountryListQuery(continentID: continentID)) { result in
            switch result {
            case .success(let graphQLResult):
                guard let countries = graphQLResult.data?.countries else {
                    completion(.failure(.generic))
                    return
                }
                
                completion(.success(countries))
            case .failure(let error):
                guard let urlError = error as? URLSessionClient.URLSessionClientError else {
                    completion(.failure(.generic))
                    return
                }
                completion(.failure(NetworkError(urlError: urlError)))
            }
        }
    }
}

