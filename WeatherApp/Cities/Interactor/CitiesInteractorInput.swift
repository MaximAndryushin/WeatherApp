//
//  CitiesInteractorInput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol CitiesInteractorInput {
    func loadCities(country: String)
    func updateWeather(city: String)
    func searchCity(city: String, cities: [String])
}
