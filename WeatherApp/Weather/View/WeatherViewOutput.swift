//
//  WeatherViewOutput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol WeatherViewOutput {
    func loadDataByGeolocation()
    func loadDataByCity(city: String)
    func presentCities()
    func presentFailureAlert(title: String, message: String)
}
