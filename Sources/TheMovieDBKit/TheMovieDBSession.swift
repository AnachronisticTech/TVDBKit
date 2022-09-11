internal class TheMovieDBSession {
    public private(set) static var shared = TheMovieDBSession()

    internal private(set) var token: String?
    internal let apiBaseUrl = "https://api.themoviedb.org/3"

    private var _configuration: APIConfiguration?
    internal var configuration: APIConfiguration {
        get async {
            if let config = _configuration { return config }
            switch await TheMovieDB.Configuration.getApiConfiguration() {
                case .success(let config):
                    _configuration = config
                    return config
                case .failure(let error):
                    fatalError("\(error)")
            }
        }
    }

    private init() {}

    public func setToken(_ token: String) {
        TheMovieDBSession.shared.token = token
    }
}
