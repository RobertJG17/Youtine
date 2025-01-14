//
//  YoutineApp.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData

@main
struct YoutineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Youtine.self, Todo.self])
    }
}
