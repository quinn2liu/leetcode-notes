//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

struct PredictedWeather: Codable {
    let day: String
    let description: String
    let minimumTemperature: Temperature
    let maximumTemperature: Temperature
}
