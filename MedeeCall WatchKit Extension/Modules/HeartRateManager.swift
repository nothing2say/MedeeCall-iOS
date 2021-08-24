//
//  HeartRateManager.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2/1/21.
//

import Foundation
import HealthKit

class HeartRateManager: NSObject, ObservableObject, HKLiveWorkoutBuilderDelegate, HKWorkoutSessionDelegate {
    
    var heartRate = "--"
    var session: HKWorkoutSession!
    var builder: HKLiveWorkoutBuilder!
    var healthStore = HKHealthStore()
    
    @Published var updateHRValue: String = "--"
    
    func startWorkout() {
        initWorkout()
        session.startActivity(with: Date())
        builder.beginCollection(withStart: Date()) { (success, error) in
            if !success {
                print("[Watch] Error beginning collection from builder: ", String(describing: error))
            }
            
        }
        
        self.timerWorkout()
        
    }
    
    func timerWorkout() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            self.updateHRValue = self.heartRate
            sensorData["HR"] = self.heartRate
        }
    }
    
    func initWorkout() {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session.associatedWorkoutBuilder()
            
        } catch let error {
            print("[Watch] Error: Unable to create the workout session!", error)
        }
        
        // Setup session and builder
        session.delegate = self
        builder.delegate = self
        
        // Set the workout builder's data source
        builder.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        print("Workout initialized")
    }
    
    func stopWorkOut() {
        session.end()
        builder.endCollection(withEnd: Date()) { (success, error) in
            self.builder.finishWorkout { (workout, error) in
                DispatchQueue.main.async {
                    self.session = nil
                    self.builder = nil
                }
            }
            
            self.heartRate = "--"
            print("workout ended")
        }
    
    }
    
    // MARK: HKWorkoutSessionDelegate
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        print("entered workoutbuilder")
        
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return
            }
            switch quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let statistics = workoutBuilder.statistics(for: quantityType)
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let value = statistics?.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
                heartRate = String(Int(Double(round(1 * value!) / 1)))
                
                print("[workoutBuilder] Heart Rate: \(heartRate)")
            default:
                return
            }
        }
    }
    
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        // Retreive the workout event.
        guard let workoutEventType = workoutBuilder.workoutEvents.last?.type else { return }
        print("[workoutBuilderDidCollectEvent] Workout Builder changed event: \(workoutEventType.rawValue)")
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        print("[workoutSession] Changed State: \(toState.rawValue)")
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("[workoutSession] Encountered an error: \(error)")
    }
    
    
    
}
