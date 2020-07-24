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
        
        presenter.loadCities(country: "RU")
        configureSearchBar()
        configureTableView()
    }
    
    // MARK: - Configurations
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
    }
    
    private func configureTableView() {
        tableCity.dataSource = self
        tableCity.delegate = self
        tableCity.translatesAutoresizingMaskIntoConstraints = false
        tableCity.backgroundColor = Colors.blue
        tableCity.tableHeaderView = searchBar
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
        presenter.searchCity(city: searchBar.text!, cities: cities)
        closeSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        closeSearch()
    }
    
    private func closeSearch() {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}


// MARK: - CitiesViewInput
extension CitiesViewController: CitiesViewInput {
    func success(cities: [String]) {
        self.cities = cities
    }
    
    func failure() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось получить список городов", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
