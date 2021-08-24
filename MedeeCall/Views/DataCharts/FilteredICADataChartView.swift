//
//  ChatView.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2/1/21.
//

import SwiftUI
import Charts

struct FilteredICADataChartView : View {
    var parent: LiveVitalView

    var body: some View {
        FilteredICAChartView( parent:parent)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onAppear(perform: updateChart)
    }
    func updateChart(){
        parent.videoProcessor.updateFilteredICAChart()
    }
}

struct FilteredICAChartView: UIViewRepresentable {
    var parent: LiveVitalView
    
    func updateUIView(_ lineChart: LineChartView, context: Context) {
        parent.lineChartsFilteredICA.setLineChart( lineChart )
    }
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }

}

