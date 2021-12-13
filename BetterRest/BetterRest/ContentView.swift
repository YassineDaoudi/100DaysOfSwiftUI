//
//  ContentView.swift
//  BetterRest
//
//  Created by Yassine DAOUDI on 10/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var restTime: String {
        let sleepTime = calculateBedtime()
        return sleepTime
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Form {
                    
                    Section(header: Text("When do you want to wake up ?")) {
                        DatePicker("When you want to wake up ?", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    .textCase(.none)
                    
                    Section(header: Text("Desired amount of sleep")) {
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                                .font(.system(.subheadline, design: .monospaced))
                        }
                    }
                    .textCase(.none)
                    
                    Section(header: Text("Your daily coffee intake:")) {
                        Picker("Coffee amount", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text("\($0) ☕️")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    .textCase(.none)
                    
                    
                    
                    //                Section(header: Text("Your ideal bedtime is ...")) {
                    //                    Text(restTime)
                    //                        .font(.system(size: 20, weight: .regular, design: .monospaced))
                    //
                    //
                    //                }
                    //                .textCase(.none)
                    
                    
                    
                }
                .navigationBarTitle("BetterSleep 😴")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                
                VStack(alignment: .center) {
                    Text("Your ideal bedtime is ...")
                    Text(restTime)
                }
                
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .frame(width: 300, height: 50, alignment: .center)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 1.0))
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0.0, y: 20)
                .padding(.top, 650)
            }
            
            
        }
        
        
    }
    
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        
        var sleep = ""
        
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.hour ?? 0) * 60
        
        do {
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formater = DateFormatter()
            formater.timeStyle = .short
            sleep = formater.string(from: sleepTime)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
        
        return sleep
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
