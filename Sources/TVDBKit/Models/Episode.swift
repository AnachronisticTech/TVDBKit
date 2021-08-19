//
//  Episode.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 10, 2021

import Foundation

public struct Episode : Codable, CustomStringConvertible {
    public let id : Int
    public let name : String
    public let episodeNumber : Int
    public let seasonNumber : Int
    public let airDate : Date

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id = "id"
        case name = "name"
        case seasonNumber = "season_number"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airDate = CustomFormatter.shared
            .createDate(from: try values.decode(String.self, forKey: .airDate))
        episodeNumber = try values.decode(Int.self, forKey: .episodeNumber)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        seasonNumber = try values.decode(Int.self, forKey: .seasonNumber)
    }

    public var description: String {
        return "S\(seasonNumber)E\(episodeNumber): \(name), aired: \(airDate), id: \(id)"
    }
}

struct CustomFormatter {
    static var shared = CustomFormatter()
    let formatter = DateFormatter()
    let timezone = TimeZone(abbreviation: "UTC")!
    let calendar = Calendar.current

    private init() {
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timezone
    }

    func createDate(from string: String) -> Date {
        let date = CustomFormatter.shared.formatter.date(from: string)!
        let components = CustomFormatter.shared.calendar.dateComponents(in: CustomFormatter.shared.timezone, from: date)
        return CustomFormatter.shared.calendar.date(from: components)!
    }
}
