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
        
        func startSessionTimer() {
            data = []
            seconds = 0
        }
        
        func endSessionTimer() {
        }
        
        func saveSession() {
            //Save data and upload to database
        }
    }
}
