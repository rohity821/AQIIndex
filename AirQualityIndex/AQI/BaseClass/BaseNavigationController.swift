//
//  BaseNavigationController.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationBar.barStyle = .black
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navigationBar.tintColor = UIColor.black
    }

}
