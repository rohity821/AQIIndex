//
//  AQIPresenter.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 19/06/21.
//

import Foundation

protocol AQIPresenterDelegate: AnyObject {
    func reloadView()
    
    func showError()
}

protocol AQIPresenterInterface {
    
    /// Use this function to get number of rows in the section
    /// - Parameters
    /// - section : Section number for which we need the number of rows
    /// - Returns
    ///  - Int - This method returns the number of rows in the given section
    func numberOfRowsInSection(section: Int) -> Int
    
    func getCityData(forRow row: Int) -> CityDataModel?
    
    func startListeningToSocket()
    
    var delegate: AQIPresenterDelegate? { get set }
    
}

class AQIPresenter: AQIPresenterInterface, AQIInteractorDelegate {
    
    var aqiData: AQIDataModel?
    var interactor: AQIInteractor?
    
    weak var delegate: AQIPresenterDelegate?
    
    init(interactor: AQIInteractor) {
        self.interactor = interactor
        interactor.delegate = self
    }
    
    func startListeningToSocket() {
        interactor?.startListeningForMessages()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return section == 0 ? (aqiData?.cities.count ?? 0) : 0
    }
    
    func getCityData(forRow row: Int) -> CityDataModel? {
        if row <= (aqiData?.cities.count ?? 0) {
            return aqiData?.cities[row]
        }
        return nil
    }
    
    //MARK: AQIInteractorDelegate
    func interactor(didFetchData dataModel: AQIDataModel) {
        aqiData = dataModel
        delegate?.reloadView()
    }
    
    func interactor(didFailedToFetch error: WebSocketError) {
        
    }
}
