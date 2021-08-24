//
//  ComponentsView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI
import Charts

struct RawDataChartView : View {
    var parent: LiveVitalView

    var body: some View {
        RawChartView( parent:parent)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear(perform: updateChart)
    }
    func updateChart(){
        parent.videoProcessor.updateRawChart()
    }
}

struct RawChartView: UIViewRepresentable {
    var parent: LiveVitalView
    
    func updateUIView(_ lineChart: LineChartView, context: Context) {
        lineChart.chartDescription.text = "Raw RGB data"
//        lineChart.backgroundColor = UIColor.green
        parent.lineChartsRaw.setLineChart( lineChart )
    }
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }

}


