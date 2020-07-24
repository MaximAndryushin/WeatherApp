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
    
    var presenter: CitiesViewOutput!
    
    private var cities: [String] = [] {
        didSet {
            tableCity.reloadData()
        }
    }
    
    private var tableCity = UITableView()
    
    private let searchBar = UISearchBar()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadCities()
        configureSearchBar()
        configureTableView()
    }
    
    // MARK: - Configurations
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Поиск"
        searchBar.barTintColor = Colors.blue
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func configureTableView() {
        tableCity.dataSource = self
        tableCity.delegate = self
        tableCity.translatesAutoresizingMaskIntoConstraints = false
        tableCity.backgroundColor = Colors.blue
        view.addSubview(tableCity)
        NSLayoutConstraint.activate([
            tableCity.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.bottomAnchor),
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
        presenter.presentCity(city: cities[indexPath.row])
    }
}


// MARK: - UISearchBarDelegate
extension CitiesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchCity(citySearch: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.loadCities()
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCity(citySearch: searchText)
    }
}


// MARK: - CitiesViewInput
extension CitiesViewController: CitiesViewInput {
    func success(cities: [String]) {
        self.cities = cities
    }
    
    func failure() {
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить список городов")
    }
}
