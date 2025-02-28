//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var authService = FirebaseAuthService()
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            
            Group {
                if authService.userSession == nil {
                    LoginView(authService: authService)
                } else {
                    MainView(authService: authService)
                }
            }
            .onAppear {
                // MARK: Set screenWidth and screenHeight
                screenWidth.wrappedValue = width
                screenHeight.wrappedValue = height
            }
            .preferredColorScheme(.dark)
        }
    }
}
