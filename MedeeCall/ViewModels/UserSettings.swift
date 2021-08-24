//
//  UserSettings.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {

    let objectWillChange = ObservableObjectPublisher()
    var pauseBetweenSamples = VideoSettings.getPauseBetweenSamples() {
        didSet {
//            print("pauseBetweenSamples \(pauseBetweenSamples)")
            VideoSettings.setPauseBetweenSamples(pauseBetweenSamples)
            objectWillChange.send()
        }
    }
    var filterStart = String( format: "%.2f", VideoSettings.getFilterStart()){
        didSet {
            guard let value = Double(filterStart) else {
                return
            }
            VideoSettings.setFilterStart(value)
            objectWillChange.send()
        }
    }
    var filterEnd = String( format: "%.2f", VideoSettings.getFilterEnd()){
        didSet {
            guard let value = Double(filterEnd) else {
                return
            }
            VideoSettings.setFilterEnd(value)
            objectWillChange.send()
        }
    }
    var frameRate = VideoSettings.getFrameRate(){
        didSet{
            VideoSettings.setFrameRate(frameRate)
            objectWillChange.send()
        }
    }
    var framesPerHeartRateSample = String( format: "%d", VideoSettings.getFramesPerHeartRateSample()){
        didSet {
            guard let value = Int(framesPerHeartRateSample) else {
                return
            }
            VideoSettings.setFramesPerHeartRateSample(value)
            objectWillChange.send()
        }
    }

}

