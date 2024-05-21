//
//  TableViewController.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 21.05.2024.
//

import UIKit

private let reuseIdentifier = "cell"

class PushViewController: UITableViewController {
    
    private let weatherData = WeatherViewModel.shared
    private lazy var searchResults = weatherData.deafultCitiesArray
    
    private var onQueryChange: ((String) -> Void)?
    
    private var searchQuery = "" {
        didSet {
            onQueryChange?(searchQuery)
        }
    }
    
    private let screen = UIScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Choose your City"
        
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .systemCyan
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        showSearchBarButton(sholdShow: true)
        
    }
    
    // MARK: - Search bar
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.sizeToFit()
        bar.showsCancelButton = true
        return bar
    }()
    
    @objc private func handleShowSearchBar() {
        search(sholdShow: true)
        searchBar.becomeFirstResponder()
    }
    
    
    private func showSearchBarButton(sholdShow: Bool) {
        if sholdShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    private func search(sholdShow: Bool) {
        showSearchBarButton(sholdShow: !sholdShow)
        searchBar.showsCancelButton = sholdShow
        navigationItem.titleView = sholdShow ? searchBar : nil
    }
    
    
    
    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let selectedCity = searchResults[indexPath.row]
        WeatherViewModel.shared.userWeather = selectedCity
        self.dismiss(animated: true)
    }
    }


extension PushViewController: UISearchBarDelegate { // Реализация работы SarchBar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(sholdShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            self.searchQuery = searchText.capitalized
            self.fetchSearchResults(for: self.searchQuery)
        }
    }
}
private extension PushViewController { // Обновление денных в таблице
    func fetchSearchResults(for query: String) {
        searchResults = weatherData.deafultCitiesArray.filter { city in
            city.name
                .capitalized(with: nil)
                .contains(searchQuery)
        }
        
        if searchResults.isEmpty {
            searchResults = weatherData.deafultCitiesArray
        }
        
        tableView.reloadData()
    }
}

