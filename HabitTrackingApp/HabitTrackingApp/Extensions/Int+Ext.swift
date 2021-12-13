//
//  Int+Ext.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 16/11/2021.
//

import Foundation

extension Int {
    
    func convertToMinutes() -> Int {
        let inputUnit: UnitDuration =  .hours
        let inputMeasurement = Measurement(value: Double(self), unit: inputUnit)
        let minutes = inputMeasurement.converted(to: .minutes)
        return Int(minutes.value)
    }
    
    func convertToHours() -> Int {
        let inputUnit: UnitDuration =  .minutes
        let inputMeasurement = Measurement(value: Double(self), unit: inputUnit)
        let hours = inputMeasurement.converted(to: .hours)
        return Int(hours.value)
    }
}
