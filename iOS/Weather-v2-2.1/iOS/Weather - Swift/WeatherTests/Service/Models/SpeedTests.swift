//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

@testable import Weather
import XCTest

final class SpeedTests: XCTestCase {

    // MARK: - CustomStringConvertible

    func test_description() {
        let speed: Speed = .milesPerHour(16.0)

        XCTAssertEqual(speed.description, "16.0 mi/h")
    }

    // MARK: - Extension

    func test_asMetersPerSecond() {
        // TODO: Implement to increase test coverage
    }

    func test_asKilometersPerHour() {
        // TODO: Implement to increase test coverage
    }

    func test_asMilesPerHour() {
        // TODO: Implement to increase test coverage
    }

    func test_asKnots() {
        // TODO: Implement to increase test coverage
    }

}
