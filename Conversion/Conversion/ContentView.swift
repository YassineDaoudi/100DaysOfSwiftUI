//
//  ContentView.swift
//  Conversion
//
//  Created by Yassine DAOUDI on 4/8/2021.
//

import SwiftUI


enum MeasurementUnits: String, CaseIterable, Identifiable {
    
    var id: String { self.rawValue }
    case speed
    case length
    case duration
    case temperature
}

struct ContentView: View {

    
    @State private var userInput = ""
    @State private var inputUnit = 2
    @State private var outputUnit = 2
    @State private var measurementUnit = 0
    @State private var symbol = ""

    
    let lengthUnits: [UnitLength] = [.kilometers, .hectometers, .decameters, .meters, .decimeters, .centimeters, .millimeters, .feet, .yards, .miles, .astronomicalUnits, .fathoms, .furlongs, .inches]
    let speedUnits: [UnitSpeed] = [.kilometersPerHour, .metersPerSecond, .milesPerHour, .knots]
    let durationUnits: [UnitDuration] = [.hours, .minutes, .seconds, .milliseconds, .microseconds, .nanoseconds, .picoseconds]
    let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    let measurements = ["speed", "length", "duration", "temperature"]
    let unitIcons = ["hare", "ruler", "hourglass", "thermometer"]
    
    var convertedValue: Double {
        let input = Double(userInput) ?? 0
        let converted = convertTo(measurement: measurements[measurementUnit], value: input)
        return converted
    }
    
    func convertTo(measurement: String, value input: Double) -> Double {

        switch measurement {
        
        case "speed":
            
            let inputUnit =  speedUnits[inputUnit]
            let outputUnit =  speedUnits[outputUnit]
            let inputMeasurement = Measurement(value: input, unit: inputUnit)
            let meters = inputMeasurement.converted(to: .kilometersPerHour)
            let converted = meters.converted(to: outputUnit)
            return converted.value
            
        case "length":
            
            let inputUnit =  lengthUnits[inputUnit]
            let outputUnit =  lengthUnits[outputUnit]
            let inputMeasurement = Measurement(value: input, unit: inputUnit)
            let meters = inputMeasurement.converted(to: .meters)
            let converted = meters.converted(to: outputUnit)
            return converted.value
            
        case "duration":
            //symbol = durationUnits[outputUnit].symbol
            let inputUnit =  durationUnits[inputUnit]
            let outputUnit =  durationUnits[outputUnit]
            let inputMeasurement = Measurement(value: input, unit: inputUnit)
            let meters = inputMeasurement.converted(to: .minutes)
            let converted = meters.converted(to: outputUnit)
            return converted.value
            
        case "temperature":
            //symbol = temperatureUnits[outputUnit].symbol
            let inputUnit =  temperatureUnits[inputUnit]
            let outputUnit =  temperatureUnits[outputUnit]
            let inputMeasurement = Measurement(value: input, unit: inputUnit)
            let meters = inputMeasurement.converted(to: .celsius)
            let converted = meters.converted(to: outputUnit)
            return converted.value
            
        default:
            let inputUnit =  lengthUnits[inputUnit]
            let outputUnit =  lengthUnits[outputUnit]
            let inputMeasurement = Measurement(value: input, unit: inputUnit)
            let meters = inputMeasurement.converted(to: .meters)
            let converted = meters.converted(to: outputUnit)
            return converted.value
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header:
                            Text("\(measurements[measurementUnit].capitalized)")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.262745098, green: 0.3254901961, blue: 0.9960784314, alpha: 1)))
                ) {
                Picker("", selection: $measurementUnit) {

                    ForEach(0..<measurements.count) {
                        Image(systemName: unitIcons[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
               }
               .textCase(.none)
                
                
                Section(header:
                            Text("Value to convert")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.262745098, green: 0.3254901961, blue: 0.9960784314, alpha: 1)))
                ) {
                    HStack {
                        
                        TextField("", text: $userInput)
                            .keyboardType(.decimalPad)
                        
                        if !userInput.isEmpty {
                            Button(action: {
                                self.userInput = ""
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(Color(UIColor.opaqueSeparator))
                            }
                        }
                    }
                }.textCase(.none)
                
                Section(header:
                            Text("Original Unit")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.262745098, green: 0.3254901961, blue: 0.9960784314, alpha: 1)))
                ) {
                    Picker("Original unit", selection: $inputUnit) {
                        
                        switch measurements[measurementUnit] {
                        
                        case "speed":
                            ForEach(0..<speedUnits.count) {
                                Text("\(speedUnits[$0].symbol)")
                            }
                            
                        case "length":
                            ForEach(0..<lengthUnits.count) {
                                Text("\(lengthUnits[$0].symbol)")
                            }
                            
                        case "duration":
                            ForEach(0..<durationUnits.count) {
                                Text("\(durationUnits[$0].symbol)")
                            }
                            
                        case "temperature":
                            ForEach(0..<temperatureUnits.count) {
                                Text("\(temperatureUnits[$0].symbol)")
                            }
                        
                        default:
                            ForEach(0..<lengthUnits.count) {
                                Text("\(lengthUnits[$0].symbol)")
                            }
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .textCase(.none)
                
                Section(header:
                            Text("Unit to convert to")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.262745098, green: 0.3254901961, blue: 0.9960784314, alpha: 1)))
                ) {
                    Picker("Original unit", selection: $outputUnit) {
                        
                        switch measurements[measurementUnit] {
                        
                        case "speed":
                            ForEach(0..<speedUnits.count) {
                                Text("\(speedUnits[$0].symbol)")
                            }
                            
                        case "length":
                            ForEach(0..<lengthUnits.count) {
                                Text("\(lengthUnits[$0].symbol)")
                            }
                            
                        case "duration":
                            ForEach(0..<durationUnits.count) {
                                Text("\(durationUnits[$0].symbol)")
                            }
                        
                        case "temperature":
                            ForEach(0..<temperatureUnits.count) {
                                Text("\(temperatureUnits[$0].symbol)")
                            }
                            
                        default:
                            ForEach(0..<lengthUnits.count) {
                                Text("\(lengthUnits[$0].symbol)")
                            }
                        }

                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .textCase(.none)
                
                Section(header:
                            Text("Converted Value")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.262745098, green: 0.3254901961, blue: 0.9960784314, alpha: 1)))
                ) {
                    Text("\(convertedValue, specifier: "%.2F")")
                    
                }
                .textCase(.none)
            }
            .navigationBarTitle("Unit Converter")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
