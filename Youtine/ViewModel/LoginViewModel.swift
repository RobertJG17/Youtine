//
//  AuthViewModel.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import FirebaseAuth
import Foundation
import AuthenticationServices

class LoginViewModel {
    var userSession: User?
    var authService: FirebaseAuthSerivice
    
    init() {
        
    }
    
    func handleAppleSignInRequest(withRequest request: ASAuthorizationAppleIDRequest) {
        print("In handleAppleSignInRequest: ", request)
    }
    
    func handleAppleSignInCompletion(withResult result: Result<ASAuthorization, any Error>) {
        print("In handleAppleSignInCompletion: ", result)
    }
}


