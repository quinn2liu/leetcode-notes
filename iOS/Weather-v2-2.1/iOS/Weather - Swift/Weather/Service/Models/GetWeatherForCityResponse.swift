//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

struct GetWeatherForCityResponse: Codable {
    let currentWeather: CurrentWeather
    let predictedWeathers: [PredictedWeather]
}
