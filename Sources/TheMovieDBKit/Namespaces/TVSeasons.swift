import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    public enum TVSeasons {
        public static func getDetails(ofSeason season: Int, forShow id: Int) async -> Result<Season, TheMovieDBError> {
            guard let token = TheMovieDBSession.shared.token else {
                return .failure(.bearerTokenNotSetError)
            }

            let url = URL(string: "\(TheMovieDBSession.shared.apiBaseUrl)/tv/\(id)/season/\(season)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

            // Hanging bug solved by Ankit at https://stackoverflow.com/a/43502499
            return Decoders.seasonDecoder.decode(await URLSession(configuration: .default).dataTask(with: request))
        }
    }
}
