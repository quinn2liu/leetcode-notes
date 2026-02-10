//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

@testable import Weather
import XCTest

final class TemperatureTests: XCTestCase {

    // MARK: - CustomStringConvertible

    func test_description() {
        let temperature: Temperature = .fahrenheit(98.0)

        XCTAssertEqual(temperature.description, "98.0 ºF")
    }

    // MARK: - Extension

    func test_asCelsius() {
        // TODO: Implement to increase test coverage
    }

    func test_asFahrenheit() {
        // TODO: Implement to increase test coverage
    }

    func test_asRankine() {
        // TODO: Implement to increase test coverage
    }

}
