//
//  WeatherIteractor.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class WeatherIteractor {
    
    // MARK: Properties
    
    weak var presenter: WeatherIteractorOutput!
    let serviceProvider = ServiceProvider<TemperatureProvider>()
    let locationManager = LocationManager()
}


// MARK: - WeatherInteractorInput
extension WeatherIteractor: WeatherIteractorInput {
    func loadWeather(city: String) {
        serviceProvider.load(service: .getTemperature(city: city), decodeType: Response.self) {
            result in
            switch result {
            case .success(let response):
                self.presenter.succes(city: response.name, weather: String(response.main.temp) + "° C")
            case .failure(let error):
                debugPrint(error)
                self.presenter.failure()
            }
        }
    }
    
    
    func loadCityAndWeatherByGeolocation() {
        let (latitude, longitude) = locationManager.getLocation()
        guard let lat = latitude, let lon = longitude else {
            self.presenter.failure()
            return
        }
        serviceProvider.load(service: .getTemperatureByCoordinates(lat: lat, lon: lon), decodeType: Response.self) {
            result in
            switch result {
            case .success(let response):
                self.presenter.succes(city: response.name, weather: String(response.main.temp) + "° C")
            case .failure(let error):
                debugPrint(error)
                self.presenter.failure()
            }
        }
    }
}
