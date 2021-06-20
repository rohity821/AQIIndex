//
//  AQIInteractor.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 19/06/21.
//

import Foundation

protocol AQIInteractorInterface {
    /// Configure interactor delegate with this variable
    var delegate: AQIInteractorDelegate? {get set}
    
    /// Use this function to start listening to messages from web socket for data updates
    func startListeningForMessages()
}

protocol AQIInteractorDelegate: AnyObject {
    /// This function will be called when data is fetched from the socket
    /// - Parameters
    ///  - dataModel: object of type `AQIDataModel` after parsing the response recieved
    func interactor(didFetchData dataModel: AQIDataModel)
    
    /// This function will be called when data fetching failed.
    /// - Parameters
    /// - an object of type `WebSocketError` which returns the error faced during network call or parsing of data
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
