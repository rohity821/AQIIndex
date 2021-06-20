//
//  AQIInteractor.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 19/06/21.
//

import Foundation

protocol AQIInteractorInterface {
    var delegate: AQIInteractorDelegate? {get set}
    func startListeningForMessages()
}

protocol AQIInteractorDelegate: AnyObject {
    func interactor(didFetchData dataModel: AQIDataModel)
    
    func interactor(didFailedToFetch error: WebSocketError)
}

class AQIInteractor: AQIInteractorInterface, WebSocketDelegate {
    weak var delegate: AQIInteractorDelegate?
    
    private var socketTask: WebSocketInterface?
    
    init(webSocketTask: WebSocketInterface) {
        socketTask = webSocketTask
        socketTask?.delegate = self
    }
    
    func startListeningForMessages() {
        socketTask?.startListeningToSocket()
    }
    
    //MARK: WebSocketDelegate
    func websocket(didFail error: WebSocketError) {
        delegate?.interactor(didFailedToFetch: error)
    }
    
    func websocket(didFetchResponse response: AQIDataModel) {
        delegate?.interactor(didFetchData: response)
    }
    
}
