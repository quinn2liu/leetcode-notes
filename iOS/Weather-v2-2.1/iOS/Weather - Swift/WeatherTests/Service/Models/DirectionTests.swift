//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

@testable import Weather
import XCTest

final class DirectionTests: XCTestCase {

    // MARK: - CustomStringConvertible

    func test_description() {
        let direction: Direction = .southeast

        XCTAssertEqual(direction.description, "Southeast")
    }

}
