import Foundation

extension TheMovieDB {
    public enum Convenience {
        public static func getEpisodes(ofShow id: Int) async -> Result<[Season.Episode], TheMovieDBError> {
            switch await TheMovieDB.TV.getDetails(ofShow: id) {
                case .failure(let error):
                    return .failure(error)
                case .success(let series):
                    var episodes = [Season.Episode]()
                    var errors = [TheMovieDBError]()
                    for number in 1...series.numberOfSeasons {
                        switch await TheMovieDB.TVSeasons.getDetails(ofSeason: number, forShow: id) {
                            case .success(let season):
                                episodes.append(contentsOf: season.episodes)
                            case .failure(let error):
                                errors.append(error)
                        }
                    }

                    episodes = episodes
                        .filter { $0.airDate != nil }
                        .sorted(by: { $0.airDate! < $1.airDate! })

                    if errors.isEmpty {
                        return .success(episodes)
                    } else {
                        return .failure(.seasonDecodingError(errors, episodes))
                    }
            }
        }
    }
}
