//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

import SwiftUI

@available(iOS 17.0, *)
struct WeatherView: View {

    let weatherService: WeatherService
    @State var viewModel: CitiesViewModel
    @State var path: NavigationPath = NavigationPath()
    
    init(service: WeatherService) {
        self.weatherService = service
        _viewModel = State(initialValue: CitiesViewModel(service: service))
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.countryCityMap.isEmpty {
                    Text("Loading Countries")
                    
                    ProgressView()
                } else {
                    
                    CountryList()
                    
                }
            }
        }
        .navigationTitle("Cities")
        .task { // we use task because if the view deletes, then this stops execution
            await viewModel.loadData()
        }
    }
    
    @ViewBuilder
    private func CountryList() -> some View {
        List {
            ForEach(Array(viewModel.countryCityMap.keys), id: \.self) { country in
                Section(header: Text(country).font(.title2).bold()) {
                    if let cities = viewModel.countryCityMap[country] {
                        ForEach(cities, id: \.name) { city in
                            NavigationLink(destination: CityView(city: city, service: weatherService)) {
                                Text(city.name)
                            }
                        }
                    } else {
                        Text("No cities")
                    }
                }
            }
        }
    }
    
//    @ViewBuilder
//    private func CityList(country: String) -> some View {
//        if let cities = viewModel.countryCityMap[country] {
//            List(cities, id: \.name) { city in
//                NavigationLink(destination: CityView(city: city, service: weatherService)) {
//                    HStack {
//                        Text(city.name)
                        
//                        Spacer()
//                    }
//                    .padding()
//                    .background(.gray)
//                    .foregroundStyle(Color.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(.blue, lineWidth: 4)
//                    }
//                }
//            }
//            
//        } else {
//            Text("No cities in \(country)")
//        }
//    }

    // MARK: - Private



}
//
//struct WeatherView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        WeatherView()
//    }
//
//}
