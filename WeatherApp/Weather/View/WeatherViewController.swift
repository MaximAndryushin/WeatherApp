//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Colors {
        static let blue = UIColor(red: 95/255, green: 170/255, blue: 230/255, alpha: 1)
        static let white = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    }

    // MARK: - Properties
    
    var presenter: WeatherViewOutput!
    
    let cityLabel = UILabel()
    let weatherLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.blue
        
        configureLabel(label: cityLabel, size: 30)
        configureLabel(label: weatherLabel, size: 50)
        
        //
        cityLabel.text = "Москва"
        weatherLabel.text = "21"
        //
        
        setupStack()
        setupButtonHome()
        setupButtonMenu()
        
        presenter.loadDataByGeolocation()
    }
    
    // MARK: - Configuratios
    
    private func configureLabel(label: UILabel, size: CGFloat) {
        label.textColor = Colors.white
        label.font = .systemFont(ofSize: size, weight: .medium)
        label.textAlignment = .center
    }
    
    private func setupStack() {
        
        let cityAndWeatherStack = UIStackView()
        
        cityAndWeatherStack.addArrangedSubview(cityLabel)
        cityAndWeatherStack.addArrangedSubview(weatherLabel)
        
        cityAndWeatherStack.axis = .vertical
        cityAndWeatherStack.spacing = 30
        
        cityAndWeatherStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityAndWeatherStack)
        
        cityAndWeatherStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityAndWeatherStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupButtonHome() {
        
        let homeButton = UIButton()
        homeButton.setImage(UIImage(named: "icon_home.png"), for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.addTarget(self, action: #selector(findWeatherByGeolocation), for: .touchUpInside)
        
        view.addSubview(homeButton)
        homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    private func setupButtonMenu() {
        
        let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "icon_menu.png"), for: .normal)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        
        view.addSubview(menuButton)
        menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
    }
    
    // MARK: - Active
    
    @objc private func findWeatherByGeolocation() {
        presenter.loadDataByGeolocation()
    }
    
    @objc private func openMenu() {
        presenter.openMenu()
    }
    
    @objc private func updateCity() {
        
    }
}


// MARK: - WeatherViewInput
extension WeatherViewController: WeatherViewInput {
    func succes(city: String, weather: String) {
        cityLabel.text = city
        weatherLabel.text = weather
    }
    
    func failure() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось получить данные", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
