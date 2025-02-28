//
//  HeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct HeaderView: View {
    @State private var amount = -4.0
    
    @Environment(\.screenHeight) var screenHeight
    
    var authService: FirebaseAuthService
    
    init(authService: FirebaseAuthService) {
        self.authService = authService
    }
    
    var body: some View {
        Text("Youtine")
            .font(
                .system(
                    size: 50,
                    weight: .ultraLight,
                    design: .rounded
                )
            )
            .frame(maxWidth: .infinity, maxHeight: screenHeight.wrappedValue / 7)
            .underline(true, pattern: .solid)
            .background(alignment: .trailing) {
                if authService.userSession != nil {
                    Image(systemName: "door.right.hand.open")
                        .resizable()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .padding(.trailing, 16)
                }
                
            }
            .preferredColorScheme(.dark)
    }
}

#Preview {
    HeaderView(authService: FirebaseAuthService())
}
