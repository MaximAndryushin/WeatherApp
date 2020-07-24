//
//  WeatherViewInput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol WeatherViewInput: AnyObject {
    func success(city: String, weather: String)
    func failure()
}
