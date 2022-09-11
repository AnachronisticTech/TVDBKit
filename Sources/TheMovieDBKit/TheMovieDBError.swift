import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public enum TheMovieDBError: Error, CustomStringConvertible {
    case bearerTokenNotSetError
    case transportError(Error)
    case serverError(statusCode: Int)
    case emptyData
    case decodingError(Error)
    case seasonDecodingError([Error], [Season.Episode])

    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            self = .serverError(statusCode: response.statusCode)
            return
        }

        if data == nil {
            self = .emptyData
            return
        }

        return nil
    }

    public var description: String {
        switch self {
            case .bearerTokenNotSetError: 
                return "No Bearer token was provided for authentication. Please set one using `TheMovieDB.setToken(_:)`. A v4 auth token can be obtained from https://www.themoviedb.org/settings/api."
            case .transportError(let error):
                return "There was a problem communicating with the server: \(error)"
            case .serverError(statusCode: let code):
                return "The server reported en error of type \(code)."
            case .emptyData:
                return "The server response contained no data."
            case .decodingError(let error):
                return "There was a problem decoding the data received from the server: \(error)"
            case .seasonDecodingError(let errors, _):
                return "There were errors decoding a season: \(errors)"
        }
    }
}
