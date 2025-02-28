//
//  AuthService.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/21/25.
//

import Firebase
import FirebaseAuth

@Observable
class FirebaseAuthService {
    var userSession: FirebaseAuth.User?
    var authenticationError: Bool = false
    
    func updateUserSession() {
        print("Current user: \(String(describing: Auth.auth().currentUser))")
        self.userSession = Auth.auth().currentUser
    }
    
    func triggerAuthenticationError() {
        self.authenticationError = true
    }
    
    func resetAuthErrorState() {
        self.authenticationError = false
    }
    
    func signOut() {
        print("DEBUG: USER \(userSession?.uid ?? "NO_UID") signed out")
        try? Auth.auth().signOut() // signs user out on backend
        self.userSession = nil     // updates routing logic by wiping user session
    }
}
