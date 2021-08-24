//
//  LiveVitalView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI

enum LiveView: String, CaseIterable {
    case video = "Video"
    case rawData = "Raw Data"
    case filteredData = "Filtered Data"
//    case FFT = "FFT"
//    case filteredICAData = "Filtered ICA"
//    case ICA = "ICA"
    case settings = "Settings"
}

struct LiveVitalView: View {
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var phoneToWatch = PhoneToWatch()
    
    @State var vitalView = LiveView.video
        
    @State var startStopVideoButton = "Start 🙂"
    @State var heartLabel = "❤️ MedeeView ☺︎ "
    @State var pulseRateLabel = "--"
    @State var pulseRateICA = "--"
    @State var progressBarValue:CGFloat = 0
    @State var frameNumberLabel = ""

    let videoProcessor = VideoProcessor()
    var lineChartsRaw = LineCharts()
    var lineChartsFiltered = LineCharts()
    var barChartsFFT = BarCharts()
    var lineChartsFilteredICA = LineCharts()
    var barChartsFFTICA = BarCharts()
    
    var body: some View {
        VStack{
            
            pulseHeaderView
            ProgressBar(value: $progressBarValue).frame(height:10)
            segmentedControlView
            //cameraView
            
            //Spacer()
        }.onAppear(perform: {self.videoProcessor.initialize( parent:self )})
    }
    
    // MARK: --- View Components ---
    
    var pulseHeaderView: some View {
        HStack{
            Text(frameNumberLabel)
                //.padding(.trailing)
            Spacer()
            Text(heartLabel)
                //.padding(.leading)
        }
        //.padding(.top)
    }
    
    var pulseRateReference: some View {
        HStack {
            // Face Pulse
//            VStack{
//                HStack{
//                    Text("🚀 FFT")
//                        .font(.system(size: 25))
//                    //Spacer()
//                }
//                HStack{
//                    Text(pulseRateLabel)
//                        .fontWeight(.regular)
//                        .font(.system(size: 25))
//
//                    Text("bpm")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.red)
//                        //.padding(.bottom, 5.0)
//
//                    //Spacer()
//                }
//                //.onAppear(perform: phoneToWatch.activateSession)
//            }
//            .padding()
            
            // ICA
            VStack{
                HStack{
                    Text("💗 Face Pulse")
                        .font(.system(size: 25))
                    //Spacer()
                }
                HStack{
                    Text(pulseRateICA)
                        .fontWeight(.regular)
                        .font(.system(size: 25))
                    
                    Text("bpm")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        //.padding(.bottom, 5.0)
                    
                    //Spacer()
                }
                //.onAppear(perform: phoneToWatch.activateSession)
            }
            .padding()
            
            // Watch HR
            VStack{
                HStack{
                    Text("⌚️ iWatch")
                        .font(.system(size: 22))
                    //Spacer()
                }
                HStack{
                    Text("\(phoneToWatch.HeartRate)")
                        .fontWeight(.regular)
                        .font(.system(size: 25))
                    
                    Text("bpm")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        //.padding(.bottom, 5.0)
                    
                    //Spacer()
                }
                .onAppear(perform: phoneToWatch.activateSession)
            }
            .padding()
        }
    }
    
    var startButton: some View {
        Button(action: {
            self.videoProcessor.startStopCamera()
            // Start getting Heart Rate from Apple Watch
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
                self.phoneToWatch.updateUI()
            }
        }) {
            Text(startStopVideoButton)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(5)
            .font(Font.system(size: 25))
        }
        .background(Color.orange)
        .foregroundColor(.white)
//            .padding(.top, -16)
    }
    
    var cameraView: some View {
        VStack {
            pulseRateReference
            startButton
            VideoView(bgColor: .blue, videoDelegate: videoProcessor)
            
        }
    }
    
    var segmentedControlView: some View {
        VStack {
            Picker("", selection: $vitalView) {
                ForEach(LiveView.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            //.padding()
            
            chosenDataView
        }
    }
    
    
    var chosenDataView: some View {
        VStack {
            switch vitalView {
            case .rawData:
                RawDataChartView(parent: self)
            case .filteredData:
                FilteredDataChartView(parent: self)
//            case .FFT:
//                FftDataChartView(parent: self)
//            case .filteredICAData:
//                FilteredICADataChartView(parent: self)
//            case .ICA:
//                FftICADataChartView(parent: self)
            case .settings:
                SettingsView(parent: self)
            default:
                cameraView
            }
        }
        
    }


    // MARK: --- View Methods ---
    
    func testSelected( state:LiveView,  checkState:LiveView ) ->Bool{
        return (state == checkState)
    }
}

struct ProgressBar: View {
    @Binding var value:CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .opacity(0.1)
                Rectangle()
                    .frame(minWidth: 0, idealWidth:self.getProgressBarWidth(geometry: geometry),
                                maxWidth: self.getProgressBarWidth(geometry: geometry))
                    .opacity(0.5)
                    .background(Color.green)
                    .animation(.default)
            }
         }
    }
    
    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .global)
        return frame.size.width * value
    }
}


struct LiveVitalView_Previews: PreviewProvider {
    static var previews: some View {
        LiveVitalView()
    }
}



