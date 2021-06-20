//
//  AQIDataModel.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation

class AQIDataModel {
    var cities = [CityDataModel]()
    
    enum CodingKeys: String {
        case city
        case aqi
    }
    
    func updateData(responseArray: [[String: Any]]) {
        for dict in responseArray {
            if let city = dict[CodingKeys.city.rawValue] as? String,
               let aqi = dict[CodingKeys.aqi.rawValue] as? Double {
                
                if let model = cities.first(where: { $0.cityName == city }) {
                    model.updateAQI(aqi: aqi)
                } else {
                    let cityModel = CityDataModel(city: city, aqi: aqi)
                    cities.append(cityModel)
                }
            }
        }
        cities.sort(by: { $0.cityName.localizedCaseInsensitiveCompare($1.cityName) == .orderedAscending })
        cities.forEach { city in
            print(city.cityName)
        }
    }
}

class CityDataModel {
    let cityName: String
    var aqiIndex = [Double]()
    var lastUpdatedAt: Date?
    
    init(city: String, aqi: Double) {
        cityName = city
        aqiIndex.append(aqi)
        lastUpdatedAt = Date()
    }
    
    func updateAQI(aqi: Double) {
        if aqiIndex.contains(aqi) { return }
        aqiIndex.append(aqi)
        lastUpdatedAt = Date()
    }
}
