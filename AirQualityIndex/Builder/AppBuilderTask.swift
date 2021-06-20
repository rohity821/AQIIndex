//
//  ObjectBuilderTask.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation
import UIKit

struct Constants {
    static let aqiViewController = "AQIViewController"
    static let aqiDetailController = "AQIDetailController"
    static let mainStoryboard = "Main"
}

struct NetworkConstants {
    static let socketUrl = "ws://city-ws.herokuapp.com"
}

class AppBuilderTask {
    private init() { }
    
    static let shared = AppBuilderTask()
    
    /// Use this function to get root view controller configured with required dependencies
    ///  - Returns:
    /// - UINavigationController - a object which needs to be be set as root view controller for the app
    func getRootViewControllerWithDependencies() -> UINavigationController? {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        if let rootVC = storyboard.instantiateViewController(withIdentifier: Constants.aqiViewController) as? AQIViewController {
            let webSocketTask = WebSocketTask(socketUrl: NetworkConstants.socketUrl)
            let interactor = AQIInteractor(webSocketTask: webSocketTask)
            let presenter = AQIPresenter(interactor: interactor)
            rootVC.insertDependency(presenter: presenter)
            let rootNC = BaseNavigationController(rootViewController: rootVC)
            return rootNC
        }
        return nil
    }
    
    /// Use this function to get AQI Detail controller object for the selected city from cell.
    ///  - Parameters
    ///  - cityData: A object of city data model which is the selected city from the table on list controller.
    ///  - Returns
    ///  - an object of AQI detail controller which needs to be pushed on view for displaying chart values.
    func getAQIDetailController(cityData: CityDataModel) -> AQIDetailController? {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Constants.aqiDetailController) as? AQIDetailController {
            let presenter = AQIDetailPresenter(cityModel: cityData)
            detailVC.configureDependencies(presenter: presenter)
            return detailVC
        }
        return nil
    }
}
