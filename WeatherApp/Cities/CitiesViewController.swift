//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import UIKit

final class CitiesViewController: UIViewController {

    // MARK: - Constants
    
    private let identifier = "CountryCell"
    
    // MARK: - Properties
    
    private let cities = Constants.defaultCities
    
    private var tableCity = UITableView() {
        didSet {
            tableCity.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableCity.dataSource = self
        tableCity.delegate = self
        tableCity.translatesAutoresizingMaskIntoConstraints = false
        tableCity.backgroundColor = Colors.blue
        view.addSubview(tableCity)
        NSLayoutConstraint.activate([
            tableCity.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableCity.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableCity.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableCity.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NotificationCenter.default.post(name: .didSelectCity, object: cities[indexPath.row])
        return configureCell(indexPath: indexPath)
    }
    
    private func configureCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCity.dequeueReusableCell(withIdentifier: identifier)
                    ?? UITableViewCell(style: .default, reuseIdentifier: identifier)
        cell.backgroundColor = Colors.blue
        let item = cities[indexPath.row]
        cell.textLabel?.text = item
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
}
