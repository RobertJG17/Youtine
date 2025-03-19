//
//  HeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct HeaderView: View {
    @Environment(RoutineEnvironment.self) var environmentContext
    @Environment(FirebaseAuthService.self) var authService
        
    func handleLogOut() {
        self.authService.signOut()
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
            .frame(maxWidth: .infinity, maxHeight: environmentContext.screenHeight / 7)
            .underline(true, pattern: .solid)
            .background(alignment: .trailing) {
                if authService.userSession != nil {
                    Button {
                        handleLogOut()
                    } label: {
                        Image(systemName: "door.right.hand.open")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .padding(.trailing, 16)
                    }
                    .foregroundStyle(Color.white)
                }
                
            }
            .preferredColorScheme(.dark)
    }
}

#Preview {
    HeaderView()
}
