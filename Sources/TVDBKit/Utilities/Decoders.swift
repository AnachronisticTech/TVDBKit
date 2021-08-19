import Foundation

protocol _ModelDecoders {
    static var seriesDecoder: ResultDecoder<Series> { get }
    static var seasonDecoder: ResultDecoder<Season> { get }
}

class _Decoders: _ModelDecoders {
    private init() {}

    static let seriesDecoder = ResultDecoder<Series> { data in
        try JSONDecoder().decode(Series.self, from: data)
    }

    static let seasonDecoder = ResultDecoder<Season> { data in
        try JSONDecoder().decode(Season.self, from: data)
    }
}
