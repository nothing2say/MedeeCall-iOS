//
//  ChatRoomView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI
import Charts

struct FftICADataChartView : View {
    var parent: LiveVitalView

    var body: some View {
        FftICAChartView( parent:parent)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onAppear(perform: updateChart)
    }
    func updateChart(){
        parent.videoProcessor.updateFFTICAChart()
    }
}

struct FftICAChartView: UIViewRepresentable {
    var parent: LiveVitalView
    
    func updateUIView(_ barChart: BarChartView, context: Context) {
        parent.barChartsFFTICA.setBarChart( barChart )
    }
    
    func makeUIView(context: Context) -> BarChartView {
        return BarChartView()
    }

}
