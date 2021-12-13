//
//  AddView.swift
//  iExpense
//
//  Created by Yassine DAOUDI on 25/8/2021.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = ""
    @State private var amount = ""
    @State private var textMessage = ""
    @State private var showingAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Form {
                    
                    Section(header: Text("Expense name :")) {
                        TextField("ex. MacBook Pro M1",text: $name)
                    }
                    .textCase(.none)
                    
                    Section(header: Text("Type :")) {
                        Picker("Type", selection: $type) {
                            ForEach(Self.types, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .textCase(.none)
                    
                    Section(header: Text("Amount :")) {
                        HStack {
                            
                            TextField("#",text: $amount)
                                .keyboardType(.numberPad)
                            
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                        }
                    }
                    .textCase(.none)
                
                }
                
                Button(action: {
                    if let actualAmount = Int(amount) {
                        if type != "" {
                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                            self.expenses.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            textMessage = "Please Choose the type of expense"
                            showingAlert = true
                        }
                    } else {
                        textMessage = "Please Enter a valid amount"
                        showingAlert = true
                    }
                    
                }) {
                    Image(systemName: "arrow.down.to.line")
                }
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .background(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
                
            }
            .navigationBarTitle("Add Expense")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid Field"), message: Text(textMessage), dismissButton: .default(Text("Ok")))
            }
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
