//
//  MainView.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 22/11/2021.
//

import SwiftUI

struct MainView: View {
    
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }

            ChartView()
                .tabItem {
                    Label("Chart", systemImage: "chart.pie")
                }
        }
    }
}
