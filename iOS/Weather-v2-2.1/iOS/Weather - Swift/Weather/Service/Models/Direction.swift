//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

enum Direction: String, Codable, CustomStringConvertible {
    case east
    case eastNortheast
    case eastSoutheast
    case north
    case northNortheast
    case northNorthwest
    case northeast
    case northwest
    case south
    case southSoutheast
    case southSouthwest
    case southeast
    case southwest
    case west
    case westNorthwest
    case westSouthwest

    // MARK: - CustomStringConvertible

    var description: String {
        switch self {
        case .east: return "East"
        case .eastNortheast: return "East Northeast"
        case .eastSoutheast: return "East Southeast"
        case .north: return "North"
        case .northNortheast: return "North Northeast"
        case .northNorthwest: return "North Northwest"
        case .northeast: return "Northeast"
        case .northwest: return "Northwest"
        case .south: return "South"
        case .southSoutheast: return "South Southeast"
        case .southSouthwest: return "South Southwest"
        case .southeast: return "Southeast"
        case .southwest: return "Southwest"
        case .west: return "West"
        case .westNorthwest: return "West Northwest"
        case .westSouthwest: return "West Southwest"
        }
    }
}
