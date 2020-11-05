import Apollo
import Foundation

final class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
}

//MARK: Network Errors

enum NetworkError: Error, Equatable {
    case generic
    case noConnection

    var readableMessage: String {
        switch self {
        case .noConnection:
            return CString.Errors.noConnection
        case .generic:
            return CString.Errors.generic
        }
    }
    
    init(urlError: URLSessionClient.URLSessionClientError) {
        switch urlError {
        case .networkError(data: _, response: _, underlying: _):
            self = .noConnection
        default:
            self = .generic
        }
    }
}
