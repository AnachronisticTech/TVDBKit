import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    public enum TV {
        public static func getDetails(
            ofShow id: Int,
            completion: @escaping (Result<Series, TheMovieDBError>) -> ()
        ) {
            guard let token = TheMovieDBSession.shared.token else {
                completion(.failure(.bearerTokenNotSetError))
                return
            }

            let url = URL(string: "\(TheMovieDBSession.shared.apiBaseUrl)/tv/\(id)")!
            let request = TheMovieDB.Request(url, token: token)

            URLSession(configuration: .default)
                .dataTask(with: request) { result in
                    completion(Decoders.seriesDecoder.decode(result))
                }
                .resume()
        }
    }
}
