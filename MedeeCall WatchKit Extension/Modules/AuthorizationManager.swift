//
//  AuthorizationManager.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2/1/21.
//

import Foundation
import HealthKit

class AuthorizationManager {
    
    var authorized: Bool = false
    let healthStore = HKHealthStore()
    
    func authorizeHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            let typesToShare: Set = [HKQuantityType.workoutType()]
            let typesToRead: Set = [HKQuantityType.quantityType(forIdentifier: .heartRate)!]
            healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
                if success {
                    self.authorized = true
                    print("[Watch] Health Store Authorized")
                    
                } else {
                    self.authorized = false
                    print("[Watch] Error authorization from health store: ", String(describing: error))
                }
            }
            authorized = true
        }
    }
}
