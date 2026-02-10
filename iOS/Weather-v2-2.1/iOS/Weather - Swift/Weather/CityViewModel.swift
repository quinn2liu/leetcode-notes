//
//  CityViewModel.swift
//  Weather
//
//  Created by Quinn Liu on 2/9/26.
//  Copyright © 2026 Uber. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

@available(iOS 17.0, *)
@Observable
class CityViewModel {
    var currentWeather: CurrentWeather?
    var predictedWeather: [PredictedWeather]?
    let city: City
    let service: WeatherService
//    var region: CLLocationCoordinate2D
    
    init(currentWeather: CurrentWeather? = nil, predictedWeather: [PredictedWeather]? = nil, city: City, service: WeatherService) {
        self.currentWeather = currentWeather
        self.predictedWeather = predictedWeather
        self.city = city
        self.service = service
//        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: city.location.latitude, longitude: city.location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    @MainActor
    func loadData() async {
        do {
            (currentWeather, predictedWeather) = try await getWeather()
        } catch CityWeatherError.GetWeatherError {
            print("GetWeatherError")
        } catch {
            print("Unexpected error: \(error.localizedDescription)")
        }
    }
    
    @concurrent
    private func getWeather() async throws -> (CurrentWeather, [PredictedWeather]) {
        guard let weatherResponse = service.waitForWeather(forCity: city) else { throw CityWeatherError.GetWeatherError }
        return (weatherResponse.currentWeather, weatherResponse.predictedWeathers)
    }
    
    enum CityWeatherError: Error {
        case GetWeatherError
    }
    
}
