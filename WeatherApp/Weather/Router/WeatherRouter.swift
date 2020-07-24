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
    func presentCities() {
        let citiesView = CitiesAssembly.assembly()
        citiesView.modalPresentationStyle = .overFullScreen
        view.present(citiesView, animated: true)
    }
    
    func presentFailureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
