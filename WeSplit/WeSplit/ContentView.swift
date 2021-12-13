//
//  ContentView.swift
//  WeSplit
//
//  Created by Yassine DAOUDI on 3/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let total = calculateCheckPlusTip()
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let grandTotal = calculateCheckPlusTip()
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    func calculateCheckPlusTip() -> Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = (orderAmount * tipSelection) / 100
        let total = orderAmount + tipValue
        return total
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.system(size: 20, weight: .light))
                            .imageScale(.large)
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                        TextField("Please enter the check amount: ", text: $checkAmount)
                            .keyboardType(.decimalPad)
                        
                        if !checkAmount.isEmpty {
                            Button(action: {
                                self.checkAmount = ""
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(Color(UIColor.opaqueSeparator))
                            }
                            
                        }
                    }
                    
                    HStack {
                        Image(systemName: "sum")
                            .font(.system(size: 20, weight: .light))
                            .imageScale(.large)
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                        TextField("People", text: $numberOfPeople)
                            .keyboardType(.decimalPad)
                        if !numberOfPeople.isEmpty {
                            Button(action: {
                                self.numberOfPeople = ""
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(Color(UIColor.opaqueSeparator))
                            }
                        }
                    }
                    
                }
                
                Section(header:
                            Text("How much tip you want to leave ?")
                            .foregroundColor(Color(#colorLiteral(red: 0.2196078431, green: 0.007843137255, blue: 0.8549019608, alpha: 1)))
                ) {
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .textCase(.none)
                
                Section(header:
                            Text(tipPercentages[tipPercentage] == 0 ? "Total amount of the check (No tip included)" : "Total amount of the check (tip included)")
                            .foregroundColor(Color(#colorLiteral(red: 0.2196078431, green: 0.007843137255, blue: 0.8549019608, alpha: 1)))
                ) {
                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.system(size: 20, weight: .light))
                            .imageScale(.large)
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                        Spacer()
                        Text("\(grandTotal, specifier: "%.2f")")
                            .foregroundColor(tipPercentages[tipPercentage] == 0 ? Color.red : Color.black)
                    }
                    
                    
                }
                .textCase(.none)
                
                Section(header:
                            Text("Each one of you should pay")
                            .foregroundColor(Color(#colorLiteral(red: 0.2196078431, green: 0.007843137255, blue: 0.8549019608, alpha: 1)))
                ) {
                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.system(size: 20, weight: .light))
                            .imageScale(.large)
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                        Spacer()
                        Text("\(totalPerPerson, specifier: "%.2f")")
                    }
                }
                .textCase(.none)
                
            }
            .navigationBarTitle("Split it")
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
