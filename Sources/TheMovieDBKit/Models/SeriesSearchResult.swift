//
// Created by Daniel on 11/09/2022.
//

import Foundation

public struct SeriesSearchResult: Codable {
    public let results: [SearchResult]
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
        results = try values.decodeIfPresent([SearchResult].self, forKey: .results) ?? []
    }

    public struct SearchResult: Codable {
        public let id: Int
        public let name: String
        public let overview: String
        public let originalName: String
        public let originalLanguage: String
        public let firstAirDate: Date?
        public let posterPath: String?
        public let backdropPath: String?
        public let popularity: Double
        public let voteAverage: Double
        public let voteCount: Int
        public let originCountry: [String]
        public let genreIds: [Int]

        enum CodingKeys: String, CodingKey {
            case id, name, overview, popularity
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case voteAverage = "vote_average"
            case firstAirDate = "first_air_date"
            case originCountry = "origin_country"
            case genreIds = "genre_ids"
            case originalLanguage = "original_language"
            case voteCount = "vote_count"
            case originalName = "original_name"
        }

        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? "No title"
            overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
            originalName = try values.decodeIfPresent(String.self, forKey: .originalName) ?? ""
            originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
            firstAirDate = TheMovieDB.createDate(from: try values.decodeIfPresent(String.self, forKey: .firstAirDate) ?? "")
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
            backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
            popularity = try values.decode(Double.self, forKey: .popularity)
            voteAverage = try values.decode(Double.self, forKey: .voteAverage)
            voteCount = try values.decode(Int.self, forKey: .voteCount)
            originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry) ?? []
            genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
        }
    }
}
