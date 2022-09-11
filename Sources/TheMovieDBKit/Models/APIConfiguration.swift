//
// Created by Daniel on 11/09/2022.
//

import Foundation

public struct APIConfiguration: Codable {
    public let images: ImageConfiguration
    public let changeKeys: [String]

    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        images = try values.decode(ImageConfiguration.self, forKey: .images)
        changeKeys = try values.decode([String].self, forKey: .changeKeys)
    }

    public struct ImageConfiguration: Codable {
        public let baseUrl: URL
        public let secureBaseUrl: URL
        public let backdropSizes: [String]
        public let logoSizes: [String]
        public let posterSizes: [String]
        public let profileSizes: [String]
        public let stillSizes: [String]

        enum CodingKeys: String, CodingKey {
            case baseUrl = "base_url"
            case secureBaseUrl = "secure_base_url"
            case backdropSizes = "backdrop_sizes"
            case logoSizes = "logo_sizes"
            case posterSizes = "poster_sizes"
            case profileSizes = "profile_sizes"
            case stillSizes = "still_sizes"
        }

        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            baseUrl = try values.decode(URL.self, forKey: .baseUrl)
            secureBaseUrl = try values.decode(URL.self, forKey: .secureBaseUrl)
            backdropSizes = try values.decode([String].self, forKey: .backdropSizes)
            logoSizes = try values.decode([String].self, forKey: .logoSizes)
            posterSizes = try values.decode([String].self, forKey: .posterSizes)
            profileSizes = try values.decode([String].self, forKey: .profileSizes)
            stillSizes = try values.decode([String].self, forKey: .stillSizes)
        }
    }
}
