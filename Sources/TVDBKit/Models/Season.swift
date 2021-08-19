//
//  Season.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 10, 2021

public struct Season : Codable {
    let episodes : [Episode]
    let seasonNumber : Int

    enum CodingKeys: String, CodingKey {
        case episodes = "episodes"
        case seasonNumber = "season_number"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        episodes = try values.decode([Episode].self, forKey: .episodes)
        seasonNumber = try values.decode(Int.self, forKey: .seasonNumber)
    }
}
