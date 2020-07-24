//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

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
}
