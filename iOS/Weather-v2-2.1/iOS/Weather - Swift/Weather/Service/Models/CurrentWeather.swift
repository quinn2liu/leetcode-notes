//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

typealias Percentage = Double

struct CurrentWeather: Codable {
    let description: String
    let feelsLikeTemperature: Temperature
    let rainChancePercent: Percentage
    let humidityPercent: Percentage
    let airPressureDescription: String
    let wind: Wind
}
