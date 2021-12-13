//
//  ActivityItem.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 10/11/2021.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    
    let icon: String
    let title: String
    let description: String
    
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    var isToggled: Bool
    var numberOfRepetition: Int
    var timeSpent: Int
    var durationSymbol: String
    
    var percent: CGFloat {
        return (Double(timeSpent)*7)/168
    }
    
    var value: CGFloat
}
