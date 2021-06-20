//
//  ViewController.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 19/06/21.
//

import UIKit

class AQIViewController: UIViewController {
    
    /// UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    /// Dependency
    var presenter: AQIPresenterInterface?
    
    /// Identifier
    private let cellIdentifier = "cityAqiIndexCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Air Quality Index"
        configureTableView()
        presenter?.startListeningToSocket()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
    }
    
    func insertDependency(presenter: AQIPresenterInterface) {
        self.presenter = presenter
        self.presenter?.delegate = self
    }

}

extension AQIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CityAQITableCell else {
            return UITableViewCell()
        }
        if let city = presenter?.getCityData(forRow: indexPath.row) {
            cell.update(city: city.cityName, aqiIndex: city.aqiIndex.first, updatedAt: city.lastUpdatedAt)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row \(indexPath.row)")
        if let city = presenter?.getCityData(forRow: indexPath.row) {
            AppRouter.shared.navigateToDetailView(cityData: city, navigationController: navigationController ?? UINavigationController())
        }
    }
    
}

extension AQIViewController: AQIPresenterDelegate {
    func reloadView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        
    }
}


