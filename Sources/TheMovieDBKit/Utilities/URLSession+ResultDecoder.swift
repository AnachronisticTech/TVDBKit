// Adapted from tutorial by Shawn Gee
// https://swiftstudent.com/2020-04-14-urlsession-and-result/

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

typealias DataResult = Result<Data, TheMovieDBError>

extension URLSession {
    func dataTask(with request: URLRequest, resultHandler: @escaping (DataResult) -> ()) -> URLSessionDataTask {
        dataTask(with: request) { data, response, error in
            if let networkError = TheMovieDBError(data: data, response: response, error: error) {
                resultHandler(.failure(networkError))
                return
            }
            resultHandler(.success(data!))
        }
    }

    func dataTask(with request: URLRequest) async -> DataResult {
        await withCheckedContinuation { continuation in
            dataTask(with: request, resultHandler: continuation.resume(returning:)).resume()
        }
    }
}

struct ResultDecoder<T> {
    private let transform: (Data) throws -> T

    init(_ transform: @escaping (Data) throws -> T) {
        self.transform = transform
    }

    func decode(_ result: DataResult) -> Result<T, TheMovieDBError> {
        result.flatMap { data in
            Result { try transform(data) }
                .mapError { TheMovieDBError.decodingError($0) }
        }
    }
}
