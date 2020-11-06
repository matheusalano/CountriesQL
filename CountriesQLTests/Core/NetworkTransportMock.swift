import Foundation
import Apollo

final class NetworkTransportMock<T: GraphQLSelectionSet>: NetworkTransport {
    
    private final class MockTask: Cancellable {
            func cancel() { }
        }
    
    private let result: Result<T, Error>
    
    init(result: Result<T, Error>) {
        self.result = result
    }
    
    func send<Operation: GraphQLOperation>(operation: Operation, cachePolicy: CachePolicy, contextIdentifier: UUID?, callbackQueue: DispatchQueue, completionHandler: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) -> Cancellable {
        
        switch result {
        case .success(let data):
            let result = GraphQLResult(data: data as? Operation.Data, extensions: nil, errors: nil, source: .cache, dependentKeys: nil)
            completionHandler(.success(result))
        case .failure(let error):
            completionHandler(.failure(error))
        }
        
        return MockTask()
    }
}
