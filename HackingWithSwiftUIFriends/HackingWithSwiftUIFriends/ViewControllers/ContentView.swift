//
//  ContentView.swift
//  HackingWithSwiftUIFriends
//
//  Created by Yassine DAOUDI on 14/1/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
            .navigationTitle("Friends")
            .task {
                do {
                    users = try await NetworkManager.shared.getUsers()
                } catch(let error) {
                    print(error)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
