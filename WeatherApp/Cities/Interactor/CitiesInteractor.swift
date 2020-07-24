//
//  CitiesInteractor.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class CitiesInteractor {
    
    // MARK: Properties
    
    weak var presenter: CitiesInteractorOutput!
}


// MARK: - CitiesInteractorInput
extension CitiesInteractor: CitiesInteractorInput {
    func searchCity(citySearch: String, country: String) {
        guard let cityList = Bundle.main.url(forResource: "CityList", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: cityList)
            let allCities = try JSONDecoder().decode([City].self, from: data)
            
            let citiesOfCountry = allCities.filter({ $0.country == country }).sorted { $0.name < $1.name }
            
            let cities = citiesOfCountry.map({ $0.name })
            
            if citySearch.isEmpty {
                presenter.succes(cities: cities)
                return
            }
            
            var newCities: [String] = []
            cities.forEach { (city) in
                
                if city.count > citySearch.count, String(city[..<city.index(city.startIndex, offsetBy: citySearch.count)]) == citySearch {
                    newCities.append(city)
                }
            }
            presenter.succes(cities: newCities)
        }catch {
            presenter.failure()
        }
    }
    
    func loadCities(country: String) {
        guard let cityList = Bundle.main.url(forResource: "CityList", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: cityList)
            let allCities = try JSONDecoder().decode([City].self, from: data)
            
            let citiesOfCountry = allCities.filter({ $0.country == country }).sorted { $0.name < $1.name }
            
            let cities = citiesOfCountry.map { $0.name }
            
            presenter.succes(cities: cities)
        
        }catch {
            presenter.failure()
        }
    }
    
    func updateWeather(city: String) {
        NotificationCenter.default.post(name: .didSelectCity, object: city)
    }
}
