//
//  AuthService.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/21/25.
//

import Firebase
import FirebaseAuth

@Observable
class AuthService {
    var userSession: FirebaseAuth.User?
    
    func updateUserSession() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String,
               password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.updateUserSession()
            print("DEBUG: Hello user \(result.user.uid)")
        } catch {
            print("DEBUG: User login failed in AUTH SERVICE: \(error.localizedDescription)")
            throw error
        }
        
    }
    
    func signOut() {
        print("DEBUG: USER \(userSession?.uid ?? "NO_UID") signed out")
        try? Auth.auth().signOut() // signs user out on backend
        self.userSession = nil     // updates routing logic by wiping user session
    }
}
