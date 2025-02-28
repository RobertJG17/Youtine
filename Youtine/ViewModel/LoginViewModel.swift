//
//  AuthViewModel.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import FirebaseAuth
import FirebaseCore
import Foundation
import AuthenticationServices
import GoogleSignIn

class LoginViewModel {
    var authService: FirebaseAuthService
    var appleAuthService: AppleAuthService
    var googleAuthService: GoogleAuthService
        
    init(authService: FirebaseAuthService) {
        self.authService = authService
        self.appleAuthService = AppleAuthService(authService: authService)
        self.googleAuthService = GoogleAuthService(authService: authService)
    }
    
    func handleAppleSignInRequest(withRequest request: ASAuthorizationAppleIDRequest) {
        appleAuthService.handleAppleSignInRequest(withRequest: request)
    }
    
    func handleAppleSignInCompletion(withResult result: Result<ASAuthorization, any Error>) {
        appleAuthService.handleAppleSignInCompletion(withResult: result)
    }
    
    func handleSignInWithGoogle() {
        googleAuthService.handleSignInWithGoogle()
    }
}
