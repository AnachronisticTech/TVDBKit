//
// Created by Daniel on 11/09/2022.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    internal enum Configuration {
        public static func getApiConfiguration() async -> Result<APIConfiguration, TheMovieDBError> {
            guard let token = TheMovieDBSession.shared.token else {
                return .failure(.bearerTokenNotSetError)
            }

            let url = URL(string: "\(TheMovieDBSession.shared.apiBaseUrl)/configuration")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

            let result = await URLSession(configuration: .default).dataTask(with: request)
            print("", terminator: "")
            return Decoders.apiConfigurationDecoder.decode(result)
        }
    }
}
