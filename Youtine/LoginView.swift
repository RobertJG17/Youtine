//
//  LoginView.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    @Environment(RoutineEnvironment.self) var environmentContext
    @Environment(FirebaseAuthService.self) var authService
    
    @State private var vm: LoginViewModel
    
    init(authService: FirebaseAuthService) {
        self.vm = LoginViewModel(authService: authService)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView()
            
            Spacer()
    
            SignInWithAppleButton { request in
                authService.resetAuthErrorState()
                vm.handleAppleSignInRequest(withRequest: request)
            } onCompletion: { result in
                vm.handleAppleSignInCompletion(withResult: result)
            }
            .frame(width: environmentContext.screenWidth / 2.2, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(.white, lineWidth: 2)
            )
        
            Divider()
                .foregroundStyle(Color.white)
                .frame(width: environmentContext.screenWidth / 2.2)
                .padding(.vertical, 5)
            
            Button {
                authService.resetAuthErrorState()
                vm.handleSignInWithGoogle()
            } label: {
                Image("Google_SI")
                    .resizable() // ???: Look into why this works
            }
            .frame(width: environmentContext.screenWidth / 2.2, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
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
