//
//  ContentView.swift
//  NeurableCodingTask
//
//  Created by Jackson Mai on 4/22/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Chart {
                    ForEach(viewModel.chartData) { chartData in
                        LineMark(
                            x: .value("Seconds", chartData.data.offsetSeconds),
                            y: .value("Focus Level", chartData.data.focusLevel),
                            series: .value(chartData.id, chartData.id)
                        )
                    }
                }
                .chartXScale(domain: viewModel.xAxisRange)
                .onReceive(viewModel.timer, perform: viewModel.updateData)
                Button {
                    viewModel.sessionButtonTapped()
                } label: {
                    Text(viewModel.isTimerRunning ? "Stop Session" : "Begin Session")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Focus Level")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.chartData.isEmpty && !viewModel.isTimerRunning {
                        Button {
                            viewModel.saveSession()
                        } label: {
                            Text("Save")
                        }
                    }
                }
            }
            .padding()
        }
    }

}

#Preview {
    ContentView()
}
