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
    private let locationManager = LocationManager.shared
}


// MARK: - CitiesInteractorInput
extension CitiesInteractor: CitiesInteractorInput {
    func searchCity(citySearch: String) {
        locationManager.getCountry { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            var country: String
            if let placeMarks = placemarks, placeMarks.count > 0, let place = placeMarks.first, let countryFromGeo = place.isoCountryCode {
                country = countryFromGeo
            } else {
                country = "RU"
            }
            guard let cityList = Bundle.main.url(forResource: "CityList", withExtension: "json") else { return }
            
            do {
                let data = try Data(contentsOf: cityList)
                let allCities = try JSONDecoder().decode([City].self, from: data)
                
                let citiesOfCountry = allCities.filter({ $0.country == country }).sorted { $0.name < $1.name }
                
                let cities = citiesOfCountry.map({ $0.name })
                
                if citySearch.isEmpty {
                    self.presenter.succes(cities: cities)
                    return
                }
                
                var newCities: [String] = []
                cities.forEach { (city) in
                    
                    if city.count > citySearch.count, String(city[..<city.index(city.startIndex, offsetBy: citySearch.count)]) == citySearch {
                        newCities.append(city)
                    }
                }
                self.presenter.succes(cities: newCities)
            }catch {
                self.presenter.failure()
            }
        }
    }
    
    func loadCities() {
        locationManager.getCountry { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            var country: String
            if let placeMarks = placemarks, placeMarks.count > 0, let place = placeMarks.first, let countryFromGeo = place.isoCountryCode {
                country = countryFromGeo
            } else {
                country = "RU"
            }
            guard let cityList = Bundle.main.url(forResource: "CityList", withExtension: "json") else { return }
            
            do {
                let data = try Data(contentsOf: cityList)
                let allCities = try JSONDecoder().decode([City].self, from: data)
                
                let citiesOfCountry = allCities.filter({ $0.country == country }).sorted { $0.name < $1.name }
                
                let cities = citiesOfCountry.map { $0.name }
                
                self.presenter.succes(cities: cities)
                
            }catch {
                self.presenter.failure()
            }
        }
        
    }
    
    func updateWeather(city: String) {
        NotificationCenter.default.post(name: .didSelectCity, object: city)
    }
}
