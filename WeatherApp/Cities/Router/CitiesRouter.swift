//
//  CitiesRouter.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class CitiesRouter {
    
    // MARK: - Properties
    
    weak var view: CitiesViewController!
}

extension CitiesRouter: CitiesRouterInput {
    func presentFailureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func dismissCities() {
        view.dismiss(animated: true, completion: nil)
    }
}
