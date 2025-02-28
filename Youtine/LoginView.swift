//
//  LoginView.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    var authService: FirebaseAuthService
    var vm: LoginViewModel
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    init(authService: FirebaseAuthService) {
        self.authService = authService
        self.vm = LoginViewModel(authService: authService)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView(authService: authService)
            
            Spacer()
    
            SignInWithAppleButton { request in
                authService.resetAuthErrorState()
                vm.handleAppleSignInRequest(withRequest: request)
            } onCompletion: { result in
                vm.handleAppleSignInCompletion(withResult: result)
            }
            .frame(width: screenWidth.wrappedValue / 2.2, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 2)
            )
        
            Divider()
                .foregroundStyle(Color.white)
                .frame(width: screenWidth.wrappedValue / 2.2)
                .padding(.vertical, 5)
            
            Button {
                authService.resetAuthErrorState()
                vm.handleSignInWithGoogle()
            } label: {
                Image("Google_SI")
            }
            .frame(width: screenWidth.wrappedValue / 2.2, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 2)
            )
            
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView(authService: FirebaseAuthService())
}
