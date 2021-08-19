import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol _TVSeasons {
    static func getDetails(
        ofSeason season: Int, forShowWithId id: Int,
        completion: @escaping (Result<Season, TVDBError>) -> ()
    )
}

public extension _TVSeasons {
    static func getDetails(
        ofSeason season: Int, forShowWithId id: Int,
        completion: @escaping (Result<Season, TVDBError>) -> () = { _ in }
    ) {
        guard let token = TVDBSession.shared.token else { 
            completion(.failure(.bearerTokenNotSetError))
            return
        }

        let url = URL(string: "\(TVDBSession.shared.apiBaseUrl)/tv/\(id)/season/\(season)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        URLSession(configuration: .default)
        // Hanging bug solved by Ankit at https://stackoverflow.com/a/43502499
            .dataTask(with: request) { result in
                completion(TVDB.Decoders.seasonDecoder.decode(result))
            }
            .resume()
    }
}
