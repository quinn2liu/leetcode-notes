//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

typealias Rate = Double

enum Speed: Codable, CustomStringConvertible {
    case metersPerSecond(Rate)
    case kilometersPerHour(Rate)
    case milesPerHour(Rate)
    case knots(Rate)

    // MARK: - CustomStringConvertible

    var description: String {
        switch self {
        case let .metersPerSecond(rate): return "\(rate) m/s"
        case let .kilometersPerHour(rate): return "\(rate) km/h"
        case let .milesPerHour(rate): return "\(rate) mi/h"
        case let .knots(rate): return "\(rate) kn"
        }
    }
}

extension Speed {

    var asMetersPerSecond: Speed {
        switch self {
        case .metersPerSecond: return self
        case let .kilometersPerHour(rate): return .metersPerSecond(rate / 3.6)
        case let .milesPerHour(rate): return .metersPerSecond(rate / 2.237)
        case let .knots(rate): return .metersPerSecond(rate / 1.944)
        }
    }

    var asKilometersPerHour: Speed {
        switch self {
        case let .metersPerSecond(rate): return .kilometersPerHour(rate * 3.6)
        case .kilometersPerHour: return self
        case let .milesPerHour(rate): return .kilometersPerHour(rate * 1.609)
        case let .knots(rate): return .kilometersPerHour(rate * 1.852)
        }
    }

    var asMilesPerHour: Speed {
        switch self {
        case let .metersPerSecond(rate): return .milesPerHour(rate * 2.237)
        case let .kilometersPerHour(rate): return .milesPerHour(rate / 1.609)
        case .milesPerHour: return self
        case let .knots(rate): return .milesPerHour(rate * 1.151)
        }
    }

    var asKnots: Speed {
        switch self {
        case let .metersPerSecond(rate): return .knots(rate * 1.944)
        case let .kilometersPerHour(rate): return .knots(rate / 1.852)
        case let .milesPerHour(rate): return .knots(rate / 1.151)
        case .knots: return self
        }
    }
}
