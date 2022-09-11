import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    public enum TVSeasons {
        public static func getDetails(
            ofSeason season: Int, forShow id: Int,
            completion: @escaping (Result<Season, TheMovieDBError>) -> ()
        ) {
            guard let token = TheMovieDBSession.shared.token else {
                completion(.failure(.bearerTokenNotSetError))
                return
            }

            let url = URL(string: "\(TheMovieDBSession.shared.apiBaseUrl)/tv/\(id)/season/\(season)")!
            let request = TheMovieDB.Request(url, token: token)

            URLSession(configuration: .default)
            // Hanging bug solved by Ankit at https://stackoverflow.com/a/43502499
                .dataTask(with: request) { result in
                    completion(Decoders.seasonDecoder.decode(result))
                }
                .resume()
        }
    }
}
