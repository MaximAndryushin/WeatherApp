//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class WeatherRouter {
    
    // MARK: - Properties
    
    weak var view: WeatherViewController!
}


// MARK: - WeatherRouterInput
extension WeatherRouter: WeatherRouterInput {
    func presentMenu() {
        // Здесь будет работа со вторым окном, где будет выбор городов
    }
}
