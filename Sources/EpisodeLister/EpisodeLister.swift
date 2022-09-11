import TheMovieDBKit
import Foundation

/// API reference: https://developers.themoviedb.org/3/getting-started/introduction

@main
struct EpisodeLister {
    static func main() async {
        let errorResult = await TheMovieDB.TV.getDetails(ofShow: Show.Constantine)
        switch errorResult {
            case .success(let series):
                print("[SUCCESS] series: \(series)")
            case .failure(let error):
                print("[ERROR] \(error)")
        }

        TheMovieDB.setToken(Constants.apiKey)

        let seriesResult = await TheMovieDB.TV.getDetails(ofShow: Show.Constantine)
        switch seriesResult {
            case .success(let series):
                print("[SUCCESS] series: \(series)")
            case .failure(let error):
                print("[ERROR] \(error)")
        }

        let seasonResult = await TheMovieDB.TVSeasons.getDetails(ofSeason: 1, forShow: Show.Stargirl)
        switch seasonResult {
            case .success(let season):
                print("[SUCCESS] season: \(season.name)")
            case .failure(let error):
                print("[ERROR] \(error)")
        }

        let episodesResult = await TheMovieDB.Convenience.getEpisodes(ofShow: Show.Stargirl)
        switch episodesResult {
            case .success(let episodes):
                print("[SUCCESS] episodes: \(episodes.map({ $0.name }).joined(separator: ", "))")
            case .failure(let error):
                print("[ERROR] \(error)")
        }
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
