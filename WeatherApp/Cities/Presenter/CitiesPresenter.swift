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
    func searchCity(city: String, cities: [String]) {
        interactor.searchCity(city: city, cities: cities)
    }
    
    func loadCities(country: String) {
        interactor.loadCities(country: country)
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
