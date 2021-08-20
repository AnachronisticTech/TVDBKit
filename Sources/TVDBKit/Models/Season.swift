//
//  Season.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 10, 2021

// public struct Season: Codable {
//     let episodes: [Episode]
//     let seasonNumber: Int

//     enum CodingKeys: String, CodingKey {
//         case episodes = "episodes"
//         case seasonNumber = "season_number"
//     }

//     public init(from decoder: Decoder) throws {
//         let values = try decoder.container(keyedBy: CodingKeys.self)
//         episodes = try values.decode([Episode].self, forKey: .episodes)
//         seasonNumber = try values.decode(Int.self, forKey: .seasonNumber)
//     }
// }

//
//  Season.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 20, 2021

import Foundation

public struct Season: Codable {
    // let _id: String?
    let airDate: Date?
    let episodes: [Episode]
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        // case _id = "_id"
        case airDate = "air_date"
        case episodes = "episodes"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        // _id = try values.decodeIfPresent(String.self, forKey: ._id)
        airDate = TVDBDateFormatter.shared.createDate(from: try values.decodeIfPresent(String.self, forKey: .airDate) ?? "")
        episodes = try values.decodeIfPresent([Episode].self, forKey: .episodes) ?? []
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "<<No title>>"
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        seasonNumber = try values.decode(Int.self, forKey: .seasonNumber)
    }

    public struct Episode: Codable, CustomStringConvertible {
        let airDate: Date?
        let crew: [Crew]
        let episodeNumber: Int
        let guestStars: [GuestStar]
        let id: Int
        let name: String
        let overview: String
        let productionCode: String?
        let seasonNumber: Int
        let stillPath: String?
        let voteAverage: Float?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case airDate = "air_date"
            case crew = "crew"
            case episodeNumber = "episode_number"
            case guestStars = "guest_stars"
            case id = "id"
            case name = "name"
            case overview = "overview"
            case productionCode = "production_code"
            case seasonNumber = "season_number"
            case stillPath = "still_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            airDate = TVDBDateFormatter.shared.createDate(from: try values.decodeIfPresent(String.self, forKey: .airDate) ?? "")
            crew = try values.decodeIfPresent([Crew].self, forKey: .crew) ?? []
            episodeNumber = try values.decode(Int.self, forKey: .episodeNumber)
            guestStars = try values.decodeIfPresent([GuestStar].self, forKey: .guestStars) ?? []
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? "No title"
            overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
            productionCode = try values.decodeIfPresent(String.self, forKey: .productionCode)
            seasonNumber = try values.decode(Int.self, forKey: .seasonNumber)
            stillPath = try values.decodeIfPresent(String.self, forKey: .stillPath)
            voteAverage = try values.decodeIfPresent(Float.self, forKey: .voteAverage)
            voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        }

        public var description: String {
            "\(seasonNumber)x\(episodeNumber), \(name), aired: \(airDate), id: \(id)"
        }
    }

    public struct GuestStar: Codable {
        let adult: Bool?
        let character: String?
        let creditId: String?
        let gender: Int?
        let id: Int
        let knownForDepartment: String?
        let name: String?
        let order: Int?
        let originalName: String?
        let popularity: Float?
        let profilePath: String?

        enum CodingKeys: String, CodingKey {
            case adult = "adult"
            case character = "character"
            case creditId = "credit_id"
            case gender = "gender"
            case id = "id"
            case knownForDepartment = "known_for_department"
            case name = "name"
            case order = "order"
            case originalName = "original_name"
            case popularity = "popularity"
            case profilePath = "profile_path"
        }
    
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
            character = try values.decodeIfPresent(String.self, forKey: .character)
            creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
            gender = try values.decodeIfPresent(Int.self, forKey: .gender)
            id = try values.decode(Int.self, forKey: .id)
            knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            order = try values.decodeIfPresent(Int.self, forKey: .order)
            originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
            popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
            profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
        }
    }

    public struct Crew: Codable {
        let adult: Bool?
        let creditId: String?
        let department: String?
        let gender: Int?
        let id: Int
        let job: String?
        let knownForDepartment: String?
        let name: String?
        let originalName: String?
        let popularity: Float?
        let profilePath: String?

        enum CodingKeys: String, CodingKey {
            case adult = "adult"
            case creditId = "credit_id"
            case department = "department"
            case gender = "gender"
            case id = "id"
            case job = "job"
            case knownForDepartment = "known_for_department"
            case name = "name"
            case originalName = "original_name"
            case popularity = "popularity"
            case profilePath = "profile_path"
        }
    
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
            creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
            department = try values.decodeIfPresent(String.self, forKey: .department)
            gender = try values.decodeIfPresent(Int.self, forKey: .gender)
            id = try values.decode(Int.self, forKey: .id)
            job = try values.decodeIfPresent(String.self, forKey: .job)
            knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
            popularity = try values.decodeIfPresent(Float.self, forKey: .popularity)
            profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
        }
    }
}
