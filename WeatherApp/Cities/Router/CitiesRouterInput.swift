//
//  CitiesRouterInput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol CitiesRouterInput {
    func dismissCities()
    func presentFailureAlert(title: String, message: String)
}
