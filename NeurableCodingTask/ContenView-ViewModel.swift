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
        var isTimerRunning = false
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var data = [FocusData_Session.DataSample]()
        
        func getRandomDataSample(seconds: Int32) -> FocusData_Session.DataSample {
            var data = FocusData_Session.DataSample()
            data.dataQuality = Float.random(in: 1...100)
            data.focusLevel = Float.random(in: 1...100)
            if data.dataQuality < 30 {
                data.focusLevel = 0
            }
            data.offsetSeconds = seconds
            return data
        }
        
        func updateData(_: Date) {
            if isTimerRunning {
                seconds += 1
                if data.count > 30 {
                    data.remove(at: 0)
                }
                let newData = getRandomDataSample(seconds: Int32(seconds))
                if newData.focusLevel != 0 {
                   data.append(newData)
                }
                print(newData)
            }
        }
        
        func sessionButtonTapped() {
            if !isTimerRunning {
                data = []
                seconds = 0
            }
            isTimerRunning.toggle()
        }
        
        func saveSession() {
            //Save data and upload to database
        }
    }
}
