//
//  AQIDetailController.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import UIKit
import SwiftCharts

class AQIDetailController: UIViewController {

    var city: CityDataModel?
    private var presenter: AQIDetailPresenterInterface?
    
    private var chart: Chart?
    private let sideSelectorHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter?.getTitle()
        showChart(horizontal: false)
        configureNavigationBar()
    }
    
    func configureDependencies(presenter: AQIDetailPresenterInterface) {
        self.presenter = presenter
    }
    
    //MARK: Private helper functions
    private func chart(horizontal: Bool) -> Chart? {
        guard let viewPresenter = presenter else { return nil }
        let labelSettings = ChartLabelSettings(font: FontDefaults.labelFont, fontColor: .white)
        let alpha: CGFloat = 0.6
        let barModels = viewPresenter.getBarModelsArray(labelSettings: labelSettings)
        let (axisValues1, axisValues2) = (
            stride(from: 0, through: 500, by: 100).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString("", order: 0, labelSettings: labelSettings)] + barModels.map{$0.constant} + [ChartAxisValueString("", order: barModels.count, labelSettings: labelSettings)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "number of values", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Air Quality Index", settings: labelSettings.defaultVertical()))
        
        let frame = FontDefaults.chartFrame(view.frame)
        let chartFrame = chart?.frame ?? CGRect(x: 0.0, y: 100, width: frame.size.width, height: frame.size.height-70)
        
        let chartSettings = FontDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let barViewSettings = ChartBarViewSettings(animDuration: 0.5)
        let chartStackedBarsLayer = ChartStackedBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, innerFrame: innerFrame, barModels: barModels, horizontal: horizontal, barWidth: 40, settings: barViewSettings, stackFrameSelectionViewUpdater: ChartViewSelectorAlpha(selectedAlpha: 1, deselectedAlpha: alpha)) {tappedBar in
            
            guard let stackFrameData = tappedBar.stackFrameData else {return}
            
            let chartViewPoint = tappedBar.layer.contentToGlobalCoordinates(CGPoint(x: tappedBar.barView.frame.midX, y: stackFrameData.stackedItemViewFrameRelativeToBarParent.minY))!
            let viewPoint = CGPoint(x: chartViewPoint.x, y: chartViewPoint.y + 70)
            let infoBubble = InfoBubble(point: viewPoint, preferredSize: CGSize(width: 50, height: 40), superview: self.view, text: "\(stackFrameData.stackedItemModel.quantity)", font: FontDefaults.labelFont, textColor: UIColor.white, bgColor: UIColor.black)
            infoBubble.tapHandler = {
                infoBubble.removeFromSuperview()
            }
            self.view.addSubview(infoBubble)
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: FontDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartStackedBarsLayer
            ]
        )
    }
    
    private func showChart(horizontal: Bool) {
        chart?.clearView()
        if let chart = chart(horizontal: horizontal) {
            view.addSubview(chart.view)
            self.chart = chart
        }
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
    }
}
