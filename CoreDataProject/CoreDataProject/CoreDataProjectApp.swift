//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Yassine DAOUDI on 25/12/2021.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
