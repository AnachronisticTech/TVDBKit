import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    public enum TV {
        public static func getDetails(ofShow id: Int) async -> Result<Series, TheMovieDBError> {
            guard let token = TheMovieDBSession.shared.token else {
                return .failure(.bearerTokenNotSetError)
            }

            let url = URL(string: "\(TheMovieDBSession.shared.apiBaseUrl)/tv/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

            return Decoders.seriesDecoder.decode(await URLSession(configuration: .default).dataTask(with: request))
        }
    }
}
