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
}


// MARK: - WeatherInteractorInput
extension WeatherIteractor: WeatherIteractorInput {
    func loadWeather(city: String) {
        // Работа с Alamofire для определения погоды по городу
    }
    
    
    func loadCityAndWeatherByGeolocation() {
        // Работа с Alamofire для определения погоды по геопозиции
    }
}
