//
//  PhoneToWatch.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import Foundation
import WatchConnectivity

var session: WCSession!

class PhoneToWatch: NSObject, WCSessionDelegate, ObservableObject {
    
    @Published var HeartRate = "--"
    
    // Assign to local variable
    var wHR = "--"
    
    internal func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        //print("--- Message: \(message)")
        
        if let hr = message["HR"] as? String {
            wHR = hr
        }
        
        //wHR = message["HR"]! as! String
        
        //print("Phone recieve: Heart Rate = ", wHR)
    }
    
    func updateUI() {
        //print("Updating Watch HR: \(wHR)")
        HeartRate = wHR
    }
    
    func activateSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("WC session is activated")
        } else {
            print("WC session is not supported")
        }
    }
    
    // MARK: Session delegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("WC activationState: ", activationState)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}
