//
//  Copyright © Uber Technologies, Inc. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var citiesResponse: GetCitiesResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")

        let service = WeatherService()
        citiesResponse = service.waitForCities()
        
        if let city = citiesResponse?.cities.first {
            let weatherCityResponse = service.waitForWeather(forCity: city)

            print(city.name)
            print(weatherCityResponse?.currentWeather.description ?? "")
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiesResponse?.cities.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = citiesResponse?.cities[indexPath.row].name
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Implement, if necessary
    }

}
