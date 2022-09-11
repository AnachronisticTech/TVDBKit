import Foundation

internal enum Decoders {
    static let apiConfigurationDecoder = ResultDecoder<APIConfiguration> { data in
        try JSONDecoder().decode(APIConfiguration.self, from: data)
    }

    static let seriesDecoder = ResultDecoder<Series> { data in
        try JSONDecoder().decode(Series.self, from: data)
    }

    static let seriesSearchResultDecoder = ResultDecoder<SeriesSearchResult> { data in
        try JSONDecoder().decode(SeriesSearchResult.self, from: data)
    }

    static let seasonDecoder = ResultDecoder<Season> { data in
        try JSONDecoder().decode(Season.self, from: data)
    }
}
