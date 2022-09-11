//
//  Series.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 10, 2021

public struct Series: Codable {
    public let id: Int
    public let name: String
    public let numberOfEpisodes: Int
    public let numberOfSeasons: Int
    public let status: String?
    public let tagline: String?
    public let posterPath: String?
    public let inProduction: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case status, tagline
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case inProduction = "in_production"
        case posterPath = "poster_path"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        inProduction = try values.decodeIfPresent(Bool.self, forKey: .inProduction)
        name = try values.decode(String.self, forKey: .name)
        numberOfEpisodes = try values.decode(Int.self, forKey: .numberOfEpisodes)
        numberOfSeasons = try values.decode(Int.self, forKey: .numberOfSeasons)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
    }
}
