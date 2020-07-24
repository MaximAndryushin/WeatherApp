//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

final class WeatherInteractor {
    
    // MARK: - Properties
    
    weak var presenter: WeatherInteractorOutput!
    private let serviceProvider: ServiceProvider<TemperatureProvider>
    private let locationManager = LocationManager.shared
    
    init(service: ServiceProvider<TemperatureProvider>) {
        serviceProvider = service
    }
}


// MARK: - WeatherInteractorInput
extension WeatherInteractor: WeatherInteractorInput {
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
