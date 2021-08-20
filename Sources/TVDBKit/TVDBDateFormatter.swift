import Foundation

struct TVDBDateFormatter {
    static var shared = TVDBDateFormatter()
    let formatter = DateFormatter()
    let timezone = TimeZone(abbreviation: "UTC")!
    let calendar = Calendar.current

    private init() {
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timezone
    }

    func createDate(from string: String) -> Date? {
        guard let date = TVDBDateFormatter.shared.formatter.date(from: string) else { return nil }
        let components = TVDBDateFormatter.shared.calendar.dateComponents(in: TVDBDateFormatter.shared.timezone, from: date)
        return TVDBDateFormatter.shared.calendar.date(from: components)
    }
}
