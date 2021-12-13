//
//  AdressView.swift
//  CupcakeCorner-49
//
//  Created by Yassine DAOUDI on 21/11/2021.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var orders: Orders
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orders.order.name.animation())
                if orders.order.name.count > 0 && !orders.order.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    TextField("Street address", text: $orders.order.streetAddress.animation())
                    if orders.order.streetAddress.count > 0 && !orders.order.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        TextField("City", text: $orders.order.city.animation())
                        if orders.order.city.count > 0 && !orders.order.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            TextField("Zip code", text: $orders.order.zip)
                        }
                    }
                }
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orders: orders)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orders.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orders: Orders())
        }
    }
}
