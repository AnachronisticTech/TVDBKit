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
            includeAdultResults: Bool? = nil
        ) async -> Result<SeriesSearchResult, TheMovieDBError> {
            guard let token = TheMovieDBSession.shared.token else {
                return .failure(.bearerTokenNotSetError)
            }

            guard let searchTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                return .failure(.malformedInput(term))
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
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

            let result = await URLSession(configuration: .default).dataTask(with: request)
            print("", terminator: "")
            return Decoders.seriesSearchResultDecoder.decode(result)
        }
    }
}
