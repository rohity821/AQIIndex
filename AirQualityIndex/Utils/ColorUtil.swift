//
//  ColorUtil.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation
import UIKit

class ColorUtil {
    
    static func getColor(forAQI aqiIndex: Double) -> UIColor{
        let bgColor: UIColor
        if aqiIndex >= 0 && aqiIndex < 51 {
            bgColor = UIColor(red: 86/255, green: 168/255, blue: 79/255, alpha: 1.0)
        } else if aqiIndex >= 51 && aqiIndex < 101 {
            bgColor = UIColor(red: 163/255, green: 200/255, blue: 83/255, alpha: 1.0)
        } else if aqiIndex >= 101 && aqiIndex < 201 {
            bgColor = UIColor(red: 255/255, green: 248/255, blue: 52/255, alpha: 1.0)
        } else if aqiIndex >= 201 && aqiIndex < 301 {
            bgColor = UIColor(red: 242/255, green: 156/255, blue: 51/255, alpha: 1.0)
        } else if aqiIndex >= 301 && aqiIndex < 401 {
            bgColor = UIColor(red: 233/255, green: 64/255, blue: 50/255, alpha: 1.0)
        } else if aqiIndex >= 401 && aqiIndex < 501 {
            bgColor = UIColor(red: 175/255, green: 45/255, blue: 36/255, alpha: 1.0)
        } else {
            bgColor = .black /// fallback
        }
        return bgColor
    }
}

extension Double {

    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
