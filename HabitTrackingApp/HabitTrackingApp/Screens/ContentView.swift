//
//  ContentView.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 8/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    @State private var showMore = false
    @State private var amountOfTime = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items.indices, id:\.self) { index in
                    VStack(alignment: .leading, spacing: 20.0) {
                        HStack {
                            Image(systemName: activities.items[index].icon)
                                .foregroundColor(
                                    Color(Color.RGBColorSpace.sRGB,
                                          red: activities.items[index].red,
                                          green: activities.items[index].green,
                                          blue: activities.items[index].blue,
                                          opacity: 1))
                            
                            Text(activities.items[index].title)
                                .foregroundColor(
                                    Color(Color.RGBColorSpace.sRGB,
                                          red: activities.items[index].red,
                                          green: activities.items[index].green,
                                          blue: activities.items[index].blue,
                                          opacity: 1))
                                .bold()
                            
                            Spacer()
                            
                            Text(
                                activities.items[index].durationSymbol == "hr"
                                ? "\(activities.items[index].timeSpent.convertToHours()) hr"
                                : "\(activities.items[index].timeSpent) min"
                            )
                                .foregroundColor(
                                    Color(Color.RGBColorSpace.sRGB,
                                          red: activities.items[index].red,
                                          green: activities.items[index].green,
                                          blue: activities.items[index].blue,
                                          opacity: 1))
                                .bold()
                        }
                        
                        Toggle("\(activities.items[index].description)", isOn: $activities.items[index].isToggled)
                            .toggleStyle(ButtonToggleStyle())
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .lineLimit(activities.items[index].isToggled ? 20 : 1)
                            .animation(Animation.spring())
                        
                        if activities.items[index].isToggled {
                            Stepper(value: $activities.items[index].numberOfRepetition, in: 1...100, step: 1) {
                                Text("\(activities.items[index].numberOfRepetition) time(s).")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                            }
                            .animation(Animation.spring())

                            Stepper(value: $activities.items[index].timeSpent, step: activities.items[index].durationSymbol == "hr" ? 60 : 1) {
                                Text("\(activities.items[index].durationSymbol == "hr" ? activities.items[index].timeSpent.convertToHours() : activities.items[index].timeSpent) \(activities.items[index].durationSymbol)")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                            }
                            .animation(Animation.spring())
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
            .toolbar {
                Button {
                    showingAddActivity.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivity(activities: self.activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        self.activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
