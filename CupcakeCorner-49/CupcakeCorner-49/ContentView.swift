//
//  ContentView.swift
//  CupcakeCorner-49
//
//  Created by Yassine DAOUDI on 20/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var orders = Orders()
    @State private var index = 3
    
    let colors: [Color] = [.white, .pink, .brown, .teal]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select your cake type")) {
                    Picker("", selection: $orders.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .textCase(.none)
                
                Section(header: Text("Number of cakes:")) {
                    Stepper("\(orders.order.quantity)", value: $orders.order.quantity, in: 3...20)
                }
                .textCase(.none)
                
                Section {
                    Toggle("Any special requests ?", isOn: $orders.order.specialRequestEnabled.animation())
                        .toggleStyle(ButtonToggleStyle())
                    if orders.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orders.order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $orders.order.addSprinkles)
                    }
                }
                .textCase(.none)
                
                Section {
                    NavigationLink {
                        AddressView(orders: orders)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
