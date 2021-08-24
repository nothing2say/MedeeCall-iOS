//
//  LiveMedicallViewModel.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI
import Charts

struct FftDataChartView : View {
    var parent: LiveVitalView

    var body: some View {
        FftChartView( parent:parent)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onAppear(perform: updateChart)
    }
    func updateChart(){
        parent.videoProcessor.updateFFTChart()
    }
}

struct FftChartView: UIViewRepresentable {
    var parent: LiveVitalView
    
    func updateUIView(_ barChart: BarChartView, context: Context) {
        barChart.chartDescription.text = "FFT RGB data"
        parent.barChartsFFT.setBarChart( barChart )
    }
    
    func makeUIView(context: Context) -> BarChartView {
        return BarChartView()
    }

}
