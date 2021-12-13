//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Yassine DAOUDI on 24/11/2021.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
