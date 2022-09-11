internal struct TheMovieDBSession {
    static private(set) var shared = TheMovieDBSession()

    internal private(set) var token: String?
    internal let apiBaseUrl = "https://api.themoviedb.org/3"

    private init() {}

    func setToken(_ token: String) {
        TheMovieDBSession.shared.token = token
    }
}
