//
// Created by Daniel on 11/09/2022.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension TheMovieDB {
    public enum Search {
        public static func shows(
            _ term: String,
            page: Int = 1,
            languageCode: String? = nil,
            firstAirDateYear: Int? = nil,
            includeAdultResults: Bool? = nil,
            completion: @escaping (Result<SeriesSearchResult, TheMovieDBError>) -> ()
        ) {
            guard let token = TheMovieDBSession.shared.token else {
                completion(.failure(.bearerTokenNotSetError))
                return
            }

            guard let searchTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                completion(.failure(.malformedInput(term)))
                return
            }

            var urlString = "\(TheMovieDBSession.shared.apiBaseUrl)/search/tv?query=\(searchTerm)&page=\(page)"
            if let languageCode = languageCode {
                urlString += "&language=\(languageCode)"
            }
            if let firstAirDateYear = firstAirDateYear {
                urlString += "&first_air_date_year=\(firstAirDateYear)"
            }
            if let includeAdultResults = includeAdultResults {
                urlString += "&include_adult=\(includeAdultResults)"
            }

            let url = URL(string: urlString)!
            let request = TheMovieDB.Request(url, token: token)

            URLSession(configuration: .default)
                .dataTask(with: request) { result in
                    completion(Decoders.seriesSearchResultDecoder.decode(result))
                }
                .resume()
        }
    }
}
