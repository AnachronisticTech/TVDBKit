//
// Created by Daniel on 11/09/2022.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    public enum Images {
        public static func get(
            from path: String,
            completion: @escaping (Result<Data, TheMovieDBError>) -> ()
        ) {
            guard let token = TheMovieDBSession.shared.token else {
                completion(.failure(.bearerTokenNotSetError))
                return
            }

            TheMovieDB.Configuration.getApiConfiguration { result in
                switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let config):
                        let url = URL(string: "\(config.images.baseUrl)\(config.images.posterSizes[1])\(path)")! // TODO: Multiple size options
                        let request = TheMovieDB.Request(url, token: token)

                        URLSession(configuration: .default)
                            .dataTask(with: request) { result in
                                completion(result)
                            }
                            .resume()
                }
            }
        }
    }
}
