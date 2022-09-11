public enum TheMovieDB {
    public static func setToken(_ token: String) {
        TheMovieDBSession.shared.setToken(token)
    }
}
