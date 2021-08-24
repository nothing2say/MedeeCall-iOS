//
//  WatchToPhone.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2/1/21.
//

import Foundation
import WatchConnectivity

var sensorData: [String: String] = [:]

class WatchToPhone: NSObject, WCSessionDelegate {
    
    var lastMessage: CFAbsoluteTime = 0
    
    func activateSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("Watch session activated")
        } else {
            print("WC session is not supported")
        }
    }
    
    func sendPhoneMessage(message: Dictionary<String, String>) {
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        print("Sending Phone Message")
        if lastMessage + 0.5 > currentTime {
            return
        }
        
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message as [String: Any], replyHandler: nil)
        }
        lastMessage = CFAbsoluteTimeGetCurrent()
    }
    
    func sendSensorDataToPhone() {
        sendPhoneMessage(message: sensorData)
    }
    
    // MARK: WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    }
    
    
    
}
