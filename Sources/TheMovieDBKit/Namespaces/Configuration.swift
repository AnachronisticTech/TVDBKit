//
// Created by Daniel on 11/09/2022.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    internal enum Configuration {
        public static func getApiConfiguration(completion: @escaping (Result<APIConfiguration, TheMovieDBError>) -> ()) {
            guard let token = TheMovieDBSession.shared.token else {
                completion(.failure(.bearerTokenNotSetError))
                return
            }

            let url = URL(string: "\(TheMovieDBSession.shared.apiBaseUrl)/configuration")!
            let request = TheMovieDB.Request(url, token: token)

            URLSession(configuration: .default)
                .dataTask(with: request) { result in
                    completion(Decoders.apiConfigurationDecoder.decode(result))
                }
                .resume()
        }
    }
}
