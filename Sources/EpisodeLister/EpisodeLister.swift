import TheMovieDBKit
import Foundation

// https://developers.themoviedb.org/3/tv/get-tv-details
// https://www.themoviedb.org/settings/api

@main
struct EpisodeLister {
    static func main() {
        print("")
        let semaphore = DispatchSemaphore(value: 0)

        /// Missing token example
        TheMovieDB.TV.getDetails(ofShow: Show.Constantine) { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let series):
                    print("[SUCCESS] series: \(series)")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()

        // API key has been abstracted away by the developer. To enable building,
        // replace `Constants.apiKey` with a `String` v4 bearer token, or uncomment
        // and complete the following struct:
        // struct Constants {
        //     static let apiKey: String = <<V4 API KEY HERE>>
        // }
        TheMovieDB.setToken(Constants.apiKey)

        /// No show with id example
        TheMovieDB.TV.getDetails(ofShow: 80986790832457890) { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let series):
                    print("[SUCCESS] series: \(series)")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()

        /// Series example
        TheMovieDB.TV.getDetails(ofShow: Show.Constantine) { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let series):
                    print("[SUCCESS] series: \(series)")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()

        /// Season example
        TheMovieDB.TVSeasons.getDetails(ofSeason: 1, forShow: Show.Constantine) { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let season):
                    print("[SUCCESS] season: \(season)")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()

        /// Episodes example
        TheMovieDB.Convenience.getEpisodes(ofShow: Show.Constantine) { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let episodes):
                    print("[SUCCESS] episodes: \(episodes.map({ $0.name }).joined(separator: ", "))")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()

        /// Search example
        TheMovieDB.Search.shows("Star Trek") { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let search):
                    print("[SUCCESS] search: \(search)")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()

        /// Images example
        TheMovieDB.Images.get(from: "/bPsxOpHVpVCX3hFz2fxnF1Vz3Dj.jpg") { result in
            defer { semaphore.signal() }
            switch result {
                case .success(let data):
                    print("[SUCCESS] image: \(String(describing: data))")
                case .failure(let error):
                    print("[ERROR] \(error)")
            }
        }
        semaphore.wait()
    }
}

public enum Show {
    public static let Arrow = 1412
    public static let Constantine = 60743
    public static let TheFlash = 60735
    public static let Supergirl = 62688
    public static let LegendsOfTomorrow = 62643
    public static let Stargirl = 80986
}
