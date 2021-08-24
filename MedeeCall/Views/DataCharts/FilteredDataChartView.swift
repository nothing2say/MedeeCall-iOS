//
//  ComponentsViewModel.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI
import Charts

struct FilteredDataChartView : View {
    var parent: LiveVitalView

    var body: some View {
        FilteredChartView( parent:parent)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onAppear(perform: updateChart)
    }
    func updateChart(){
        parent.videoProcessor.updateFilteredChart()
    }
}

struct FilteredChartView: UIViewRepresentable {
    var parent: LiveVitalView
    
    func updateUIView(_ lineChart: LineChartView, context: Context) {
        lineChart.chartDescription.text = "Filtered RGB data"
//        lineChart.backgroundColor = UIColor.green
        parent.lineChartsFiltered.setLineChart( lineChart )
    }
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }

}

