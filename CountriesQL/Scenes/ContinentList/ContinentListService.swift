import Foundation
import Apollo

protocol ContinentListServiceProtocol {
    typealias Continent = ContinentListQuery.Data.Continent
    
    func getContinents(completion: @escaping ((Result<[Continent], Error>) -> Void))
}

final class ContinentListService: ContinentListServiceProtocol {
    let client: ApolloClient

    init(client: ApolloClient = Network.shared.apollo) {
        self.client = client
    }

    func getContinents(completion: @escaping ((Result<[Continent], Error>) -> Void)) {
        client.fetch(query: ContinentListQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                guard let continents = graphQLResult.data?.continents else {
                    completion(.failure(NSError()))
                    return
                }
                
                completion(.success(continents))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

