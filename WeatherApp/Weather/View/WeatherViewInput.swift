//
//  WeatherViewInput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

protocol WeatherViewInput: AnyObject {
    func succes(city: String, weather: String)
    func failure()
}
