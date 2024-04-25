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
                Chart(viewModel.data, id: \.self) {
                    LineMark(
                        x: .value("Seconds", $0.offsetSeconds),
                        y: .value("Focus Level", $0.focusLevel)
                    )
                }
                .onReceive(viewModel.timer) { time in
                    if viewModel.isTimerRunning {
                        viewModel.seconds += 1
                        if viewModel.data.count > 30 {
                            viewModel.data.remove(at: 0)
                        }
                        viewModel.data.append(viewModel.getRandomDataSample(seconds: Int32(viewModel.seconds)))
                    }
                }
                Button {
                    if viewModel.isTimerRunning {
                        viewModel.endSessionTimer()
                    } else if !viewModel.isTimerRunning {
                        viewModel.startSessionTimer()
                    }
                    viewModel.isTimerRunning.toggle()
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.data.isEmpty && !viewModel.isTimerRunning {
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
