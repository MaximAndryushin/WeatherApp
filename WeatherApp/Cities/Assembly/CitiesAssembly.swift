//
//  CitiesAssembly.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 24.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class CitiesAssembly {
    
    static func assembly() -> UIViewController {
        let view = CitiesViewController()
        let presenter = CitiesPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let interactor = CitiesInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = CitiesRouter()
        router.view = view
        presenter.router = router
        
        return view
    }
    
}
