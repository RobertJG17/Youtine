//
//  YoutineApp.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct YoutineApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: Contains userSession property used to authorize user access
    @State var authService = FirebaseAuthService()
    
    // MARK: Contains global UI state and relevant mutators
    @State var environmentContext = RoutineEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Routine.self, Habit.self])
        .environment(environmentContext)
        .environment(authService)
    }
}
