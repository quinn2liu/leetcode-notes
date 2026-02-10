//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

import Foundation

final class WeatherService {

    // MARK: -

    /// A synchronous request to get the list of cities.
    ///
    /// - Returns: Response object containing the list of cities.
    func waitForCities() -> GetCitiesResponse? {
        invokeGetCities(request: .init())
    }

    /// A synchronous request to get the weather for a given city.
    ///
    /// - Parameter city: City object for which the request should be made.
    /// - Returns: Response object containing the weather for a given city.
    func waitForWeather(forCity city: City) -> GetWeatherForCityResponse? {
        invokeGetWeather(request: .init(city: city))
    }

    // MARK: -

    typealias GetCitiesResponseCompletion = (GetCitiesResponse?) -> ()
    typealias GetWeatherForCityResponseCompletion = (GetWeatherForCityResponse?) -> ()

    /// An asynchronous request to get the list of cities.
    ///
    /// - Parameter completion: Completion handler which provides the response object containing the list of cities.
    func getCities(completion: GetCitiesResponseCompletion?) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let response: GetCitiesResponse = self?.invokeGetCities(request: .init()) else { return }
            DispatchQueue.main.async {
                guard let completion else { return }
                completion(response)
            }
        }
    }

    /// An asynchronous request to get the weather for a given city.
    ///
    /// - Parameter city: City object for which the request should be made.
    /// - Parameter completion: Completion handler which provides the response object containing the weather for a given city.
    func getWeather(forCity city: City, completion: GetWeatherForCityResponseCompletion?) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let response: GetWeatherForCityResponse = self?.invokeGetWeather(request: .init(city: city)) else { return }
            DispatchQueue.main.async {
                guard let completion else { return }
                completion(response)
            }
        }
    }

    // MARK: - Private

    private func createArtificialDelay() {
        Thread.sleep(forTimeInterval: TimeInterval(arc4random() % 5))
    }

    private func invokeGetCities(request: GetCitiesRequest) -> GetCitiesResponse? {
        createArtificialDelay()

        do {
            guard let path: String = Bundle.main.path(forResource: "cities", ofType: "json") else {
                throw WeatherServiceError("Resource is not available within main \(Bundle.self).")
            }
            let data: Data = try .init(contentsOf: .init(fileURLWithPath: path), options: .mappedIfSafe)
            guard let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data) as? [String: Any], !dictionary.isEmpty else {
                throw WeatherServiceError("Unable to deserialize resource from given file.")
            }
            guard var inputCities: [[String: Any]] = dictionary["cities"] as? [[String: Any]], !inputCities.isEmpty else {
                throw WeatherServiceError("Encountered unexpected resource format.")
            }
            var randomizedCities: [[String: Any]] = []
            while !inputCities.isEmpty {
                randomizedCities.append(inputCities.remove(at: Int(arc4random()) % inputCities.count))
            }
            var outputCities: [City] = []
            for cityDictionary: [String: Any] in randomizedCities {
                outputCities.append(try JSONDecoder().decode(City.self, from: try JSONSerialization.data(withJSONObject: cityDictionary, options: .fragmentsAllowed)))
            }
            return .init(cities: outputCities)
        } catch {
            print("Caught \(Error.self): \(error.localizedDescription)")
            return nil
        }
    }

    private func invokeGetWeather(request: GetWeatherForCityRequest) -> GetWeatherForCityResponse? {
        createArtificialDelay()

        do {
            let filename: String = request.city.name.replacingOccurrences(of: " ", with: "").lowercased()
            guard let path: String = Bundle.main.path(forResource: filename, ofType: "json") else {
                throw WeatherServiceError("Resource is not available within main \(Bundle.self).")
            }
            let data: Data = try .init(contentsOf: .init(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONDecoder().decode(GetWeatherForCityResponse.self, from: data)
        } catch {
            print("Caught \(Error.self): \(error.localizedDescription)")
            return nil
        }
    }
}

extension WeatherService {
    
    struct WeatherServiceError: CustomStringConvertible, LocalizedError {

        // MARK: - Initialization

        init(_ message: String,
             file: StaticString = #file,
             function: StaticString = #function,
             line: UInt = #line,
             column: UInt = #column) {
            self.message = message
            self.file = file
            self.function = function
            self.line = line
            self.column = column
        }

        // MARK: - CustomStringConvertible

        var description: String {
            "\(file) - \(function) - \(line) - \(column) : \(message)"
        }

        // MARK: - LocalizedError

        var errorDescription: String? {
            description
        }

        // MARK: - Private

        private let message: String
        private let file: StaticString
        private let function: StaticString
        private let line: UInt
        private let column: UInt
    }
}
