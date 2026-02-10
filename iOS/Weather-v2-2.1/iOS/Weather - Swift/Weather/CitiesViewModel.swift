//
//  CitiesViewModel.swift
//  Weather
//
//  Created by Quinn Liu on 2/9/26.
//  Copyright © 2026 Uber. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
@Observable
class CitiesViewModel {
    var countryCityMap: [String: [City]] = [:]
    let service: WeatherService
    
    init(countryCityMap: [String : [City]] = [:], service: WeatherService) {
        self.countryCityMap = countryCityMap
        self.service = service
    }
    
    @MainActor
    func loadData() async {
        
        // group cities by country
        let cities = await loadCities()
        countryCityMap = await groupCitiesByCountry(cities: cities)
            
//        if let city = cities.first {
//            let weatherCityResponse = service.waitForWeather(forCity: city)
//
//            print(city.name)
//            print(weatherCityResponse?.currentWeather.description ?? "")
//        }
    
    }
    
    @concurrent
    private func groupCitiesByCountry(cities: [City]) async -> [String: [City]] {
        var grouped: [String: [City]] = [:]
        for city in cities {
            grouped[city.country, default: []].append(city)
        }
        return grouped
    }
    
    @concurrent
    private func loadCities() async -> [City] {
        return service.waitForCities()?.cities ?? []
    }
    
}
