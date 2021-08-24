//
//  MainView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2021/02/12.
//

import SwiftUI
import HealthKit

struct MainView: View {
    
    init() {
        UITabBar.appearance().tintColor = UIColor.red
    }
    
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @State private var value = 0
    @State private var selection = 0
    
    var body: some View {
        
        TabView {
            LiveVitalView()
                .tabItem {
                    Image(systemName: "bolt.heart")
                    Text("MEDee")
                }
            CallView()
                .tabItem {
                    Image(systemName: "face.dashed.fill")
                    Text("Call")
                }
            HealthView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("View")
                }
        }
    }
    
    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
    
    func autorizeHealthKit() {
        let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]

        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
    
    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        // 1
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        // 2
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // 3
        guard let samples = samples as? [HKQuantitySample] else {
            return
        }
            
        self.process(samples, type: quantityTypeIdentifier)

        }
        
        // 4
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // 5
        
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var lastHeartRate = 0.0
        
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            
            self.value = Int(lastHeartRate)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
