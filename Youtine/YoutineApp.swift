//
//  YoutineApp.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI

@main
struct YoutineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
