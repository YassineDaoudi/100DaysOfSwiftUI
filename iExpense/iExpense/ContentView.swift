//
//  ContentView.swift
//  iExpense
//
//  Created by Yassine DAOUDI on 23/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        if item.amount < 10 {
                            HStack {
                                Text("$\(item.amount)")
                                    .bold()
                                
                                Image(systemName: "flag.fill")
                            }
                            .foregroundColor(.green)
                            
                        } else if item.amount < 100 {
                            HStack {
                                Text("$\(item.amount)")
                                    .bold()
                                
                                Image(systemName: "flag.fill")
                            }
                            .foregroundColor(.yellow)
                        } else {
                            HStack {
                                Text("$\(item.amount)")
                                    .bold()
                                
                                Image(systemName: "flag.fill")
                            }
                            .foregroundColor(.red)
                        }
                        
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .listStyle(SidebarListStyle())
            .navigationBarItems(leading :
                                    EditButton()
                                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
                                trailing:
                                    Button(action: {
                                        self.showingAddExpense.toggle()
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                    }
                                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
