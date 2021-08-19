// Adapted from tutorial by Shawn Gee
// https://swiftstudent.com/2020-04-14-urlsession-and-result/

import Foundation
import FoundationNetworking

typealias DataResult = Result<Data, TVDBError>

extension URLSession {
    func dataTask(with request: URLRequest, resultHandler: @escaping (DataResult) -> ()) -> URLSessionDataTask {
        self.dataTask(with: request) { data, response, error in
            if let networkError = TVDBError(data: data, response: response, error: error) {
                resultHandler(.failure(networkError))
                return
            }
            resultHandler(.success(data!))
        }
    }
}

struct ResultDecoder<T> {
    private let transform: (Data) throws -> T

    init(_ transform: @escaping (Data) throws -> T) {
        self.transform = transform
    }

    func decode(_ result: DataResult) -> Result<T, TVDBError> {
        result.flatMap { data in
            Result { try transform(data) }
                .mapError { TVDBError.decodingError($0) }
        }
    }
}
