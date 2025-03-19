//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(RoutineEnvironment.self) var environmentContext
    @Environment(FirebaseAuthService.self) var authService
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            
            ZStack {
                if authService.userSession == nil {
                    LoginView(authService: authService)
                        .transition(.move(edge: .bottom))
                } else {
                    MainView()
                        .transition(.blurReplace())
                }
            }
            .animation(.bouncy(duration: 1.5), value: authService.userSession)
            .onAppear {
                // MARK: Set screenWidth and screenHeight
                environmentContext.updateWidth(to: width)
                environmentContext.updateHeight(to: height)
            }
            .preferredColorScheme(.dark)
        }
    }
}
