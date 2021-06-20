//
//  WebsocketTask.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import Foundation

protocol WebSocketInterface {
    
    func startListeningToSocket()
    
    var delegate: WebSocketDelegate? {get set}
}

protocol WebSocketDelegate: AnyObject {
    func websocket(didFetchResponse response: AQIDataModel)
    func websocket(didFail error: WebSocketError)
}

enum WebSocketError: Error {
    case couldNotParseJSON
    case noResponseRecieved
    case unknownError
}

class WebSocketTask: NSObject, WebSocketInterface, URLSessionWebSocketDelegate {
    
    private var socketUrl: String?
    private var webSocketTask: URLSessionWebSocketTask?
    private var dataModel = AQIDataModel()
    
    weak var delegate: WebSocketDelegate?
    
    init(socketUrl: String) {
        super.init()
        self.socketUrl = socketUrl
        
    }
    
    func startListeningToSocket() {
        configureSocketConnection()
    }
    
    private func configureSocketConnection() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        if let socketUrlString = socketUrl,
           let url = URL(string: socketUrlString) {
            webSocketTask = session.webSocketTask(with: url)
            webSocketTask?.resume()
        }
    }
    
    private func ping() {
      webSocketTask?.sendPing { error in
        if let error = error {
          print("Error when sending PING \(error)")
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.ping()
            }
        }
      }
    }
    
    func close() {
      let reason = "Closing connection".data(using: .utf8)
      webSocketTask?.cancel(with: .goingAway, reason: reason)
    }
    
    
    func receive() {
      webSocketTask?.receive { [weak self] result in
        switch result {
        case .success(let message):
          switch message {
          case .data( _):
              break
          case .string(let text):
            print("Text received \(text)")
              self?.parseResponse(responseText: text)
          @unknown default:
              print("unknown case expected")
          }
        case .failure( _):
            self?.delegate?.websocket(didFail: .noResponseRecieved)
        }
          self?.receive()
      }
    }
    
    private func parseResponse(responseText: String) {
        let data = responseText.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [[String: Any]] {
                dataModel.updateData(responseArray: jsonArray)
                delegate?.websocket(didFetchResponse: dataModel)
            } else {
                delegate?.websocket(didFail: .couldNotParseJSON)
            }
        } catch {
            print(error)
            delegate?.websocket(didFail: .couldNotParseJSON)
            
        }
    }
    
    //MARK: URLSessionWebSocketDelegate
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        ping()
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web Socket did disconnect")
    }
    
    
}
