//
//  WeatherAssembly.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class WeatherAssembly {
    
    static func assembly() -> UIViewController {
        let view = WeatherViewController()
        let presenter = WeatherPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let interactor = WeatherIteractor()
        interactor.presenter = presenter
        presenter.iteractor = interactor
        
        let router = WeatherRouter()
        router.view = view
        presenter.router = router
        
        return view
    }
    
}
