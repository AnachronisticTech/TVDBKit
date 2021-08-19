struct TVDBSession {
    static var shared = TVDBSession()

    internal var token: String?
    internal let apiBaseUrl = "https://api.themoviedb.org/3"

    private init() {}

    func setToken(_ token: String) {
        TVDBSession.shared.token = token
    }
}
