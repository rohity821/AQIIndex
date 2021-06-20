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
    static let mainStoryboard = "Main"
}

struct NetworkConstants {
    static let socketUrl = "ws://city-ws.herokuapp.com"
}

class ObjectBuilderTask {
    private init() { }
    
    static let shared = ObjectBuilderTask()
    
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
}
