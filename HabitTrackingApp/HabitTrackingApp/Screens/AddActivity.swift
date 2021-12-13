//
//  AddActivity.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 8/11/2021.
//

import SwiftUI

struct AddActivity: View {
    
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss
    
    @State private var activityTitle = ""
    @State private var activityDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut tellus vitae erat mattis luctus non vel justo. Curabitur quis quam in urna aliquam semper."
    @State private var amountOfTime = ""
    @State private var iconId = 0
    @State private var inputUnit = 0
    @State private var color = Color(#colorLiteral(red: 0.9215686275, green: 0.2156862745, blue: 0.2156862745, alpha: 1))
    
    let iconArray = ["photo.on.rectangle.angled","cart.fill","heart.text.square", "book.fill", "airplane.departure", "ticket.fill", "stethoscope", "theatermasks.fill", "fuelpump.fill", "paintpalette.fill", "fork.knife", "gamecontroller.fill", "phone.fill.arrow.up.right", "cup.and.saucer.fill", "dice.fill", "music.mic", "network", "figure.walk", "bicycle", "ladybug.fill"]
    let durationUnits: [UnitDuration] = [.hours, .minutes]
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    HStack {
                        Picker("", selection: $iconId) {
                            ForEach(0..<iconArray.count) {
                                Image(systemName: iconArray[$0])
                                    .foregroundColor(color)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(color)
                        
                        Spacer()
                        
                        ColorPicker("", selection: $color)
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    TextField("Activity title", text: $activityTitle)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
            
                    TextEditor(text: $activityDescription)
                    
                    HStack {
                        TextField("Amount of time spent on it", text: $amountOfTime)
                        Picker("", selection: $inputUnit) {
                            ForEach(0..<durationUnits.count) {
                                Text(durationUnits[$0].symbol)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(color)
                    }
                }
                .navigationTitle("New Activity")
                .navigationBarItems(leading: Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.square")
                        .foregroundColor(color)
                },
                            trailing: Button(action: {
                    
                    let time = durationUnits[inputUnit].symbol == "hr" ? Int(amountOfTime)?.convertToMinutes() ?? 0 : Int(amountOfTime) ?? 0
                    
                    
                    let convertedColor = UIColor(color).rgba
                    let red = convertedColor.red
                    let green = convertedColor.green
                    let blue = convertedColor.blue
                    let alpha = convertedColor.alpha
                    
                    let activity = Activity(icon: iconArray[iconId], title: activityTitle, description: activityDescription, red: red, green: green, blue: blue, alpha: alpha, isToggled: false, numberOfRepetition: 1, timeSpent: time, durationSymbol: durationUnits[inputUnit].symbol, value: 0)
                    activities.items.append(activity)
                    
                    dismiss()
                    
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(color)
                }
                )
            }
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
