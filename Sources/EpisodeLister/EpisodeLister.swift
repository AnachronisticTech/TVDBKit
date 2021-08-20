import TVDBKit
import Foundation

// https://developers.themoviedb.org/3/tv/get-tv-details
// https://www.themoviedb.org/settings/api

@main
struct EpisodeLister {
    static func main() {
        print("")
        let semaphore = DispatchSemaphore(value: 0)

        func resultPrinter(result: Result<[Season.Episode], TVDBError>) {
            switch result {
                case .success(let episodes):
                    print("[SUCCESS] Episodes:")
                    episodes.forEach { print($0) }
                case .failure(let error):
                    print(String(describing: error))
            }
            semaphore.signal()
        }

        TVDB.Convenience.getEpisodes(ofShowWithId: Show.Constantine, completion: resultPrinter)
        semaphore.wait()

        // API key has been abstracted away by the developer. To enable building,
        // replace `Constants.apiKey` with a `String` v4 bearer token, or uncomment
        // and complete the following struct:
        // struct Constants {
        //     static let apiKey: String = <<V4 API KEY HERE>>
        // }
        TVDB.setToken(Constants.apiKey)

        TVDB.Convenience.getEpisodes(ofShowWithId: 80986790832457890, completion: resultPrinter)
        semaphore.wait()

        TVDB.TVSeasons.getDetails(ofSeason: 1, forShowWithId: Show.Constantine) { result in
            switch result {
                case .success(let season):
                    print("[SUCCESS] Season: \(season)")
                case .failure(let error):
                    print(String(describing: error))
            }
            semaphore.signal()
        }
        semaphore.wait()

        TVDB.Convenience.getEpisodes(ofShowWithId: Show.LegendsOfTomorrow, completion: resultPrinter)
        semaphore.wait()

        TVDB.TV.getDetails(ofShowWithId: Show.Constantine) { result in
            switch result {
                case .success(let series):
                    print("[SUCCESS] series: \(series)")
                case .failure(let error):
                    print(String(describing: error))
            }
            semaphore.signal()
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
