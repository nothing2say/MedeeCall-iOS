//
//  MedeeWatchView.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI

struct MedeeWatchView: View {
    
    @ObservedObject var heartRateManager = HeartRateManager()
    @State var collectionStatus: String = "Start Collecting"
    @State var workoutOn: Bool = false
    var workout = false
    
    @State var timer: Timer? = nil
    
    let watchToPhone = WatchToPhone()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    VStack {
                        Button(
                            action: {
                                //print("Heart Data On")
                                self.workoutOn.toggle()
                                if self.workoutOn {
                                    self.heartRateManager.startWorkout()
                                    self.collectionStatus = "Stop"
                                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
                                        watchToPhone.sendSensorDataToPhone()
                                    })
                                } else {
                                    self.timer?.invalidate()
                                    self.timer = nil
                                    self.heartRateManager.stopWorkOut()
                                    self.collectionStatus = "Start Collecting"
                                }
                            }) {
                            Text(collectionStatus)
                        }
                    }
                    
                    HStack{
                        Text("❤️")
                            .font(.system(size: 33))
                        Spacer()

                    }

                    HStack{
                        Text("\(heartRateManager.updateHRValue)")
                            .fontWeight(.regular)
                            .font(.system(size: 55))

                        Text(" BPM")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                            .padding(.bottom, 14)

                        Spacer()
                    }
                }
            }
            .onAppear(perform: authorizationManager.authorizeHealthKit)
        }
    }
}

struct MedeeWatchView_Previews: PreviewProvider {
    static var previews: some View {
        MedeeWatchView()
    }
}
