import Foundation

public protocol _Convenience {
    static func getEpisodes(
        ofShowWithId id: Int,
        completion: @escaping (Result<[Season.Episode], TVDBError>) -> ()
    )
}

public extension _Convenience {
    static func getEpisodes(
        ofShowWithId id: Int, 
        completion: @escaping (Result<[Season.Episode], TVDBError>) -> () = { _ in }
    ) {
        TVDB.TV.getDetails(ofShowWithId: id) { result in
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let series):
                    let group = DispatchGroup()
                    var episodes = [Season.Episode]()
                    var errors = [TVDBError]()
                    for number in 1...series.numberOfSeasons {
                        group.enter()
                        TVDB.TVSeasons.getDetails(ofSeason: number, forShowWithId: id) { result in
                            defer { group.leave() }
                            switch result {
                                case .success(let season):
                                    episodes.append(contentsOf: season.episodes)
                                case .failure(let error):
                                    errors.append(error)
                                    // completion(.failure(error))
                            }
                        }
                    }
                    group.wait()
                    episodes = episodes.filter({ $0.airDate != nil }).sorted(by: { $0.airDate! < $1.airDate! })
                    if errors.isEmpty {
                        completion(.success(episodes))
                    } else {
                        completion(.failure(.seasonDecodingError(errors, episodes)))
                    }
            }
        }
    }
}
