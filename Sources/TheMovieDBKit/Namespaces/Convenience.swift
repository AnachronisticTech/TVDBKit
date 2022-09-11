import Foundation

extension TheMovieDB {
    public enum Convenience {
        public static func getEpisodes(
            ofShow id: Int,
            completion: @escaping (Result<[Season.Episode], TheMovieDBError>) -> ()
        ) {
            TheMovieDB.TV.getDetails(ofShow: id) { result in
                switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let series):
                        let group = DispatchGroup()
                        var episodes = [Season.Episode]()
                        var errors = [TheMovieDBError]()
                        for number in 1...series.numberOfSeasons {
                            group.enter()
                            TheMovieDB.TVSeasons.getDetails(ofSeason: number, forShow: id) { result in
                                defer { group.leave() }
                                switch result {
                                    case .success(let season):
                                        episodes.append(contentsOf: season.episodes)
                                    case .failure(let error):
                                        errors.append(error)
                                }
                            }
                        }

                        group.wait()
                        episodes = episodes
                            .filter { $0.airDate != nil }
                            .sorted(by: { $0.airDate! < $1.airDate! })

                        if errors.isEmpty {
                            completion(.success(episodes))
                        } else {
                            completion(.failure(.seasonDecodingError(errors, episodes)))
                        }
                }
            }
        }
    }
}
