//
//  WorkoutView.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2021/02/12.
//

import SwiftUI
import HealthKit

let authorizationManager = AuthorizationManager()

struct WorkoutView: View {
    
    @State var workoutOn: Bool = false
    var workout = false
    @State var workoutState: String = "Start workout"
    @State var bpm: String = "--"
    
    @ObservedObject var heartRateManager = HeartRateManager()
    
    let healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    //var HeartRate: heartRate = heartRate(bpm: 0.0)
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Button(
                        action: {
                        self.workoutOn.toggle()
                            if self.workoutOn {
                                self.heartRateManager.startWorkout()
                                self.workoutState = "Stop workout"
                            } else {
                                
                                self.heartRateManager.stopWorkOut()
                                self.workoutState = "Start workout"
                            }
                        }) {
                        Text("\(workoutState)")
                    }
                }
                Text("\(heartRateManager.updateHRValue)")
            }
            .onAppear(perform: authorizationManager.authorizeHealthKit)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
