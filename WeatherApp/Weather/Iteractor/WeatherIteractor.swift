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

}


// MARK: - WeatherInteractorInput
extension WeatherIteractor: WeatherIteractorInput {
    func loadWeather(city: String) {
        // Работа с Alamofire для определения погоды по городу
        
        serviceProvider.load(service: .getTemperature(lat: 55.75, lon: 37.62), decodeType: Response.self) {
            result in
            switch result {
            case .success(let response):
                self.presenter.succes(city: response.name, weather: String(response.main.temp) + "° C")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func loadCityAndWeatherByGeolocation() {
        // Работа с Alamofire для определения погоды по геопозиции
    }
}
