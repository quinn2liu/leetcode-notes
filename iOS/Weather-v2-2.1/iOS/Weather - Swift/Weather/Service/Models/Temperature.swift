//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

typealias Degrees = Double

enum Temperature: Codable, CustomStringConvertible {
    case celsius(Degrees)
    case fahrenheit(Degrees)
    case rankine(Degrees)

    // MARK: - CustomStringConvertible

    var description: String {
        switch self {
        case let .celsius(degrees): return "\(degrees) ºC"
        case let .fahrenheit(degrees): return "\(degrees) ºF"
        case let .rankine(degrees): return "\(degrees) ºR"
        }
    }
}

extension Temperature {

    var asCelsius: Temperature {
        switch self {
        case .celsius: return self
        case let .fahrenheit(degrees): return .celsius((degrees - 32) * 5/9)
        case let .rankine(degrees): return .celsius((degrees - 491.67) * 5/9)
        }
    }

    var asFahrenheit: Temperature {
        switch self {
        case let .celsius(degrees): return .fahrenheit((degrees * 9/5) + 32)
        case .fahrenheit: return self
        case let .rankine(degrees): return .fahrenheit(degrees - 459.67)
        }
    }

    var asRankine: Temperature {
        switch self {
        case let .celsius(degrees): return .rankine(degrees * 9/5 + 491.67)
        case let .fahrenheit(degrees): return .rankine(degrees + 459.67)
        case .rankine: return self
        }
    }
}
