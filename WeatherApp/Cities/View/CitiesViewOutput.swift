//
//  CitiesViewOutput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol CitiesViewOutput{
    func loadCities(country: String)
    func presentCity(city: String)
    func searchCity(citySearch: String, country: String)
    func presentFailureAlert(title: String, message: String)
}
