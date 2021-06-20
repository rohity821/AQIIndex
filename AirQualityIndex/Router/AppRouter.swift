//
//  AppRouter.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation
import UIKit

class AppRouter {
    
    private init() { }
    
    static let shared = AppRouter()
    
    func navigateToDetailView(cityData: CityDataModel,
                              navigationController: UINavigationController) {
        if let detailVC = AppBuilderTask.shared.getAQIDetailController(cityData: cityData) {
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
