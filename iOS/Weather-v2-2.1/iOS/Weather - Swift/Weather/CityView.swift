//
//  CityView.swift
//  Weather
//
//  Created by Quinn Liu on 2/9/26.
//  Copyright © 2026 Uber. All rights reserved.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct CityView: View {
    
    @State var viewModel: CityViewModel
    
    init(city: City, service: WeatherService) {
        _viewModel = State(initialValue: CityViewModel(city: city, service: service))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            CityMap()
            
            CurrentWeatherDetails()
            
            Spacer()
        }
        .navigationTitle(viewModel.city.name)
        .task {
            await viewModel.loadData()
        }
    }
    
    // MARK: City Map
    @ViewBuilder
    private func CityMap() -> some View {
        Map(position: .constant(.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.city.location.latitude, longitude: viewModel.city.location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))))) {
            Marker(viewModel.city.name, coordinate: CLLocationCoordinate2D(latitude: viewModel.city.location.latitude, longitude: viewModel.city.location.longitude))
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    // MARK: Current Weather Details
    @ViewBuilder
    private func CurrentWeatherDetails() -> some View {
        VStack(spacing: 12) {
            if let currentWeather = viewModel.currentWeather {
                
                Text("Description: \(currentWeather.description)")
                
                HStack {
                    Text("Feels Like: \(currentWeather.feelsLikeTemperature.asFahrenheit)")
                    
                    Spacer()
                    
                    Text("Rain Chance: \(Int(currentWeather.rainChancePercent)) %")
                }
                
                PredictedWeatherDetails()
            } else {
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("Loading Weather")
                        
                        ProgressView()
                    }
                    
                    Spacer()
                }
                
            }
        }
//        struct CurrentWeather: Codable {
//            let description: String
//            let feelsLikeTemperature: Temperature
//            let rainChancePercent: Percentage
//            let humidityPercent: Percentage
//            let airPressureDescription: String
//            let wind: Wind
//        }
    }
    
    // MARK: Current Weather Details
    @ViewBuilder
    private func PredictedWeatherDetails() -> some View {
        if let predictedWeather = viewModel.predictedWeather {
            Text("Upcoming Weather")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(predictedWeather, id: \.day) { weather in
                        
                        VStack {
                            Text(weather.day)
                            
                            Text("Description: \(weather.description)")
                            
                            HStack {
                                Text("Min: \(weather.minimumTemperature.asFahrenheit)")
                                
                                Text("Max: \(weather.maximumTemperature.asFahrenheit)")

                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        struct PredictedWeather: Codable {
//                            let day: String
//                            let description: String
//                            let minimumTemperature: Temperature
//                            let maximumTemperature: Temperature
//                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CityView()
//}
