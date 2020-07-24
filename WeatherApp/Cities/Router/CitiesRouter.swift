//
//  CitiesRouter.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

final class CitiesRouter {
    
    // MARK: - Properties
    
    weak var view: CitiesViewController!
}

extension CitiesRouter: CitiesRouterInput {
    func dismissCities() {
        view.dismiss(animated: true, completion: nil)
    }
}
