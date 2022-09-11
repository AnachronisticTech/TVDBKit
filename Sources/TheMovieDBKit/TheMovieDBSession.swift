internal struct TheMovieDBSession {
    public private(set) static var shared = TheMovieDBSession()

    internal var token: String?
    internal let apiBaseUrl = "https://api.themoviedb.org/3"

    private init() {}

    public func setToken(_ token: String) {
        TheMovieDBSession.shared.token = token
    }
}
