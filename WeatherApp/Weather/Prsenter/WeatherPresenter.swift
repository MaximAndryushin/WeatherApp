//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class WeatherPresenter {
    
    // MARK: - Properties
    
    weak var view: WeatherViewInput!
    var iteractor: WeatherIteractorInput!
    var router: WeatherRouterInput!
}


// MARK: - WeatherViewOutput
extension WeatherPresenter: WeatherViewOutput {
    
    func loadDataByGeolocation() {
        iteractor.loadCityAndWeatherByGeolocation()
    }
    
    func openMenu() {
        router.presentMenu()
    }
}


// MARK: - WeatherInteractorOutput
extension WeatherPresenter: WeatherIteractorOutput {
    func succes(city: String, weather: String) {
        view.succes(city: city, weather: weather)
    }
    
    func failure() {
        view.failure()
    }
}
