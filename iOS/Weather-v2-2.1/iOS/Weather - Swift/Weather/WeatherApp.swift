//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

import SwiftUI

/// - NOTE: In order to utilize `SwiftUI`, ensure `@main` annotates `WeatherApp` below while also verifying
/// `@UIApplicationMain` is commented out and/or removed within `WeatherAppDelegate.swift`.

@main
struct WeatherApp: App {

    let service = WeatherService()
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                WeatherView(service: service)
            } else {
                    // Fallback on earlier versions
            }
        }
    }

}
