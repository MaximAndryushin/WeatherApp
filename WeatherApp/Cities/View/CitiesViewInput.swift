//
//  CitiesViewInput.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

protocol CitiesViewInput: AnyObject {
    func success(cities: [String])
    func failure()
}
