//
//  WeatherInteractorInput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol WeatherInteractorInput {
    func loadCityAndWeatherByGeolocation()
    func loadWeather(city: String)
}
