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
    
    /// Use this function to navigate to detail view of a city for chart to be displayed for AQI
    /// - Parameters
    ///  - cityData: A object of class `CityDataModel` which contains the AQI information and city name
    ///  - navigationController: A object of clas `UINavigationController` on which the view controller needs to be pushed
    /// 
    func navigateToDetailView(cityData: CityDataModel,
                              navigationController: UINavigationController) {
        if let detailVC = AppBuilderTask.shared.getAQIDetailController(cityData: cityData) {
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
