import Foundation
import FoundationNetworking

public protocol _TV {
    static func getDetails(ofShowWithId id: Int,
        completion: @escaping (Result<Series, TVDBError>) -> ())
}

public extension _TV {
    static func getDetails(
        ofShowWithId id: Int,
        completion: @escaping (Result<Series, TVDBError>) -> () = { _ in }
    ) {
        guard let token = TVDBSession.shared.token else { 
            completion(.failure(.bearerTokenNotSetError))
            return
        }

        let url = URL(string: "\(TVDBSession.shared.apiBaseUrl)/tv/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        URLSession(configuration: .default)
            .dataTask(with: request) { result in
                completion(TVDB.Decoders.seriesDecoder.decode(result))
            }
            .resume()
    }
}
