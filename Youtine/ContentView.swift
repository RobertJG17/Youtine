//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(UIStore.self) var uiStore
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
                uiStore.updateWidth(to: width)
                uiStore.updateHeight(to: height)
            }
            .preferredColorScheme(.dark)
        }
    }
}
