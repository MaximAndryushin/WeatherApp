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
    func searchCity(city: String, cities: [String]) {
        let cities2 = cities.filter { (city1) -> Bool in
            city1 == city
        }
        presenter.succes(cities: cities2)
    }
    
    func loadCities(country: String) {
        guard let cityList = Bundle.main.url(forResource: "CityList", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: cityList)
            let allCities = try JSONDecoder().decode([City].self, from: data)
            
            let citiesOfCountry = allCities.filter({ (city) -> Bool in
                city.country == country
            }).sorted { (cityOne, cityTwo) -> Bool in
                cityOne.name < cityTwo.name
            }
            
            let cities = citiesOfCountry.map { (city) -> String in
                city.name
            }
            
            presenter.succes(cities: cities)
        
        }catch {
            presenter.failure()
        }
    }
    
    func updateWeather(city: String) {
        NotificationCenter.default.post(name: .didSelectCity, object: city)
    }
}
