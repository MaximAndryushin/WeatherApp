//
//  CitiesPresenter.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

final class CitiesPresenter {
    
    // MARK: - Properties
    
    weak var view: CitiesViewInput!
    var interactor: CitiesInteractorInput!
    var router: CitiesRouterInput!
}


// MARK: - CitiesViewOutput
extension CitiesPresenter: CitiesViewOutput {
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
    
    func searchCity(citySearch: String) {
        interactor.searchCity(citySearch: citySearch)
    }
    
    func loadCities() {
        interactor.loadCities()
    }
    
    func presentCity(city: String) {
        interactor.updateWeather(city: city)
        router.dismissCities()
    }
}


// MARK: - CitiesInteractorOutput
extension CitiesPresenter: CitiesInteractorOutput {
    func succes(cities: [String]) {
        view.success(cities: cities)
    }
    
    func failure() {
        view.failure()
    }
}
