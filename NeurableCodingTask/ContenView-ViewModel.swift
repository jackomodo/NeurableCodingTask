//
//  ContenView-ViewModel.swift
//  NeurableCodingTask
//
//  Created by Jackson Mai on 4/24/24.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        var seconds = 0
        var xAxisRange = [0, 30]
        var isTimerRunning = false
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var chartData = [ChartData]()
        var labelNameCount = 0
        
        func getRandomDataSample(seconds: Int32) -> FocusData_Session.DataSample? {
            var data = FocusData_Session.DataSample()
            data.dataQuality = Float.random(in: 0...100)
            data.focusLevel = Float.random(in: 0...100)
            let randomConnectionIssue = Float.random(in: 1...10)
            if data.dataQuality < 30 || randomConnectionIssue == 1 {
                return nil
            }
            data.offsetSeconds = seconds
            return data
        }
        
        func updateData(_: Date) {
            if isTimerRunning {
                seconds += 1
                if seconds > 30 {
                    xAxisRange = xAxisRange.map { $0 + 1 }
                }
                if let newData = getRandomDataSample(seconds: Int32(seconds)) {
                    let newChartData = ChartData(id: "\(labelNameCount)", data: newData)
                    chartData.append(newChartData)
                    
                } else {
                    labelNameCount += 1
                }
            }
        }
        
        func sessionButtonTapped() {
            if !isTimerRunning {
                chartData = []
                xAxisRange = [0, 30]
                seconds = 0
            }
            isTimerRunning.toggle()
        }
        
        func saveSession() {
            //Save data and upload to database
        }
    }
}
