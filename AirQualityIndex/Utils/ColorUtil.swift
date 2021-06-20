//
//  ColorUtil.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation
import UIKit

class ColorUtil {
    
    /// Use this function to get color as per the AQI index of city
    /// - Parameters
    /// - aqiIndex - double value indicating the current air quality index of the selected city
    /// - Returns
    /// - `UIColor` as per the AQI
    static func getColor(forAQI aqiIndex: Double) -> UIColor{
        let bgColor: UIColor
        if aqiIndex >= 0 && aqiIndex < 51 {
            bgColor = .goodAQIColor
        } else if aqiIndex >= 51 && aqiIndex < 101 {
            bgColor = .satisfactoryAQIColor
        } else if aqiIndex >= 101 && aqiIndex < 201 {
            bgColor = .moderateAQIColor
        } else if aqiIndex >= 201 && aqiIndex < 301 {
            bgColor = .poorAQIColor
        } else if aqiIndex >= 301 && aqiIndex < 401 {
            bgColor = .veryPoorAQIColor
        } else if aqiIndex >= 401 && aqiIndex < 501 {
            bgColor = .severeAQIColor
        } else {
            bgColor = .black /// fallback
        }
        return bgColor
    }
}

/// Extension with all the colors for AQI index
extension UIColor {
    class var goodAQIColor: UIColor {
        return UIColor(red: 86/255, green: 168/255, blue: 79/255, alpha: 1.0)
    }
    
    class var satisfactoryAQIColor: UIColor {
        return UIColor(red: 163/255, green: 200/255, blue: 83/255, alpha: 1.0)
    }
    
    class var moderateAQIColor: UIColor {
        return UIColor(red: 255/255, green: 248/255, blue: 52/255, alpha: 1.0)
    }
    
    class var poorAQIColor: UIColor {
        return UIColor(red: 242/255, green: 156/255, blue: 51/255, alpha: 1.0)
    }
    
    class var veryPoorAQIColor: UIColor {
        return UIColor(red: 233/255, green: 64/255, blue: 50/255, alpha: 1.0)
    }
    
    class var severeAQIColor: UIColor {
        return UIColor(red: 175/255, green: 45/255, blue: 36/255, alpha: 1.0)
    }
}
