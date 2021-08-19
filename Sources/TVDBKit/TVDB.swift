import Foundation
import FoundationNetworking

public protocol _TVDB {
    static func setToken(_ token: String)
}

public extension _TVDB {
    static func setToken(_ token: String) {
        TVDBSession.shared.setToken(token)
    }
}

public enum TVDB: _TVDB {
    // Namespace of convenience functions provided by library
    public enum Convenience: _Convenience {}

    // Namespaces of functions provided by API documented at:
    // https://developers.themoviedb.org/3
    public enum TV: _TV {}
    public enum TVSeasons: _TVSeasons {}

    class Decoders: _Decoders {}
}
