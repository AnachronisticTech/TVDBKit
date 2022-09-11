import Foundation

internal struct TheMovieDBDateFormatter {
    static var shared = TheMovieDBDateFormatter()
    let formatter = DateFormatter()
    let timezone = TimeZone(abbreviation: "UTC")!
    let calendar = Calendar.current

    private init() {
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timezone
    }

    func createDate(from string: String) -> Date? {
        guard let date = TheMovieDBDateFormatter.shared.formatter.date(from: string) else { return nil }
        let components = TheMovieDBDateFormatter.shared.calendar.dateComponents(in: TheMovieDBDateFormatter.shared.timezone, from: date)
        return TheMovieDBDateFormatter.shared.calendar.date(from: components)
    }
}
