//
//  CheckoutView.swift
//  CupcakeCorner-49
//
//  Created by Yassine DAOUDI on 21/11/2021.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var orders: Orders
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding(.bottom)
                                
                Text("Your total is \(orders.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button {
                    Task {
                        await placeOrder()
                    }
                } label: {
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Place Order")
                    }
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Ok") {
                
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        
        guard let encoded = try? JSONEncoder().encode(orders.order) else {
            print("Failed to encode order")
            return
        }
        
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank you !"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            alertTitle  = "Something went wrong !"
            alertMessage = "Please try again later"
            showingAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(orders: Orders())
        }
    }
}
