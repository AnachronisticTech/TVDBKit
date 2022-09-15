import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public class TheMovieDB {
    private static let calendar = Calendar.current
    private static let timezone = TimeZone(abbreviation: "UTC")!
    internal static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timezone
        return formatter
    }()

    private init() {}

    public static func setToken(_ token: String) {
        TheMovieDBSession.shared.setToken(token)
    }

    internal static func createDate(from string: String) -> Date? {
        guard let date = dateFormatter.date(from: string) else { return nil }
        let components = calendar.dateComponents(in: timezone, from: date)
        return calendar.date(from: components)
    }

    internal static func Request(_ url: URL, token: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}
