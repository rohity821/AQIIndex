//
//  AQIDetailPresenter.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation
import SwiftCharts

protocol AQIDetailPresenterInterface {
    func getBarModelsArray(labelSettings: ChartLabelSettings) -> [ChartStackedBarModel]
}

class AQIDetailPresenter {
    
    var city: CityDataModel?
    
    init(cityModel: CityDataModel) {
        city = cityModel
    }
    
    func getBarModelsArray(labelSettings: ChartLabelSettings) -> [ChartStackedBarModel] {
        var barModels = [ChartStackedBarModel]()
        let zero = ChartAxisValueDouble(0)
        if let aqiIndexes = city?.aqiIndex {
            
            let ending = aqiIndexes.count > 5 ? aqiIndexes.count - 5 : 0
            for index in stride(from: aqiIndexes.count, to: ending, by: -1) {
                let aqi = aqiIndexes[index-1]
                let model = ChartStackedBarModel(constant: ChartAxisValueString("\(index)", order: index, labelSettings: labelSettings), start: zero, items: [
                    ChartStackedBarItemModel(quantity: aqi, bgColor: ColorUtil.getColor(forAQI: aqi))
                ])
                barModels.append(model)
            }
        }
        return barModels
    }
    
    func getTitle() -> String {
        return city?.cityName ?? "Air Quality Index"
    }
}
