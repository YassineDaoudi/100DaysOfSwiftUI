//
//  SettingScreen.swift
//  edutainment
//
//  Created by Yassine DAOUDI on 18/8/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var multiTable: Int
    @Binding var nbrQuestions: Int

    
    var numberOfQuestions = ["5", "10", "20", "All"]
    
    
//    init() {
//        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        
//        //Use this if NavigationBarTitle is with displayMode = .inline
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
//    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Which multiplication table you want to practice ?")) {
                    Stepper(value: $multiTable, in: 1...12, step: 1 ) {
                        Text("Up to \(multiTable)")
                            .bold()
                    }
                }
                .textCase(.none)
                
                Section(header: Text("How many questions you wanna be asked ?")) {
                    Picker("Number of question : ", selection: $nbrQuestions) {
                        ForEach(0..<numberOfQuestions.count) {
                            Text("\(numberOfQuestions[$0])")
                        }
                        
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .textCase(.none)
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(multiTable: .constant(0), nbrQuestions: .constant(0))
    }
}
