//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    

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
        setupStack()
        setupButtonHome()
        setupButtonMenu()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didSelectCity, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        homeButton.accessibilityIdentifier = AccessibilityIdentifier.home.rawValue
        homeButton.setImage(UIImage(named: "icon_home.png"), for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.addTarget(self, action: #selector(tapFindWeatherByGeolocation), for: .touchUpInside)
        
        view.addSubview(homeButton)
        homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    private func setupButtonMenu() {
        
        let menuButton = UIButton()
        menuButton.accessibilityIdentifier = AccessibilityIdentifier.menu.rawValue
        menuButton.setImage(UIImage(named: "icon_menu.png"), for: .normal)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(tapPresentCities), for: .touchUpInside)
        
        view.addSubview(menuButton)
        menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
    }
    
    // MARK: - Active
    
    @objc private func tapFindWeatherByGeolocation() {
        presenter.loadDataByGeolocation()
    }
    
    @objc private func tapPresentCities() {
        presenter.presentCities()
    }
    
    @objc private func onDidReceiveData(_ notification: Notification) {
        guard let city = notification.object as? String else {
            return
        }
        presenter.loadDataByCity(city: city)
    }
}


// MARK: - WeatherViewInput
extension WeatherViewController: WeatherViewInput {
    func success(city: String, weather: String) {
        cityLabel.text = city
        weatherLabel.text = weather
    }
    
    func failure() {
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить данные")
    }
}
