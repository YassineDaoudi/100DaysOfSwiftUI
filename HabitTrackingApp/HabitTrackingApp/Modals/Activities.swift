//
//  Activities.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 10/11/2021.
//

import SwiftUI

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                items = decodedActivities
                return
            }
        }
        items = []
    }
    
    func calc(){
        var value: CGFloat = 0
        
        for i in 0..<items.count {
            value += items[i].percent
            items[i].value = value
        }
    }
}
