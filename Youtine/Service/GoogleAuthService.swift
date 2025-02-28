//
//  GoogleAuthService.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/27/25.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum AuthenticationError: Error {
    case GIDTokenError(message: String)
}

class GoogleAuthService {
    var authService: FirebaseAuthService
    
    init(authService: FirebaseAuthService) {
        self.authService = authService
    }
    
    func handleSignInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return
        }
        
        Task { @MainActor in // ???: MainActor moves asynchronous execution to main thread to avoid unexpected UI behavior
            do {
                let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                let user = userAuthentication.user
                guard let idToken = user.idToken else {
                    throw AuthenticationError.GIDTokenError(message: "ID Token missing")
                }
                let accessToken = user.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                               accessToken: accessToken.tokenString)
                
                let result = try await Auth.auth().signIn(with: credential)
                let firebaseUser = result.user
                self.authService.updateUserSession()
                print("User \(firebaseUser.uid) signed in with email \(String(describing: firebaseUser.email))")
            } catch {
                print(error.localizedDescription)
                self.authService.triggerAuthenticationError()
            }
        }
    }
}
