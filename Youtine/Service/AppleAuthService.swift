//
//  AppleAuthService.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/24/25.
//

import AuthenticationServices
import Foundation
import CryptoKit
import FirebaseAuth

fileprivate struct SecurityService {
    var currentNonce: String?
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }

        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
        }

        return String(nonce)
    }
    
    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
        }.joined()

        return hashString
    }
}

class AppleAuthService {
    var authService: FirebaseAuthService
    fileprivate var securityService: SecurityService
    
    init(authService: FirebaseAuthService) {
        self.authService = authService
        self.securityService = SecurityService()
    }
    
    func handleAppleSignInRequest(withRequest request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName]
        let nonce = securityService.randomNonceString()
        securityService.currentNonce = nonce
        request.nonce = securityService.sha256(nonce)
    }
    
    func handleAppleSignInCompletion(withResult result: Result<ASAuthorization, any Error>) {
        if case .failure(let failure) = result {
            print(failure.localizedDescription)
        }
        
        else if case .success(let success) = result {
            if let appleIDCredential = success.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = securityService.currentNonce else {
                    fatalError("Invalid state: a login callback was received, but no login request was sent")
                }
                
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token.")
                    return
                }
                
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                let credential = OAuthProvider.credential(providerID: .apple,
                                                          idToken: idTokenString,
                                                          rawNonce: nonce)
                
                Task {
                    do {
                        // if this doesn't work, capture result from try await call
                        try await Auth.auth().signIn(with: credential)
                        self.authService.updateUserSession()
                    } catch {
                        print("Error authenticating: \(error.localizedDescription)")
                        self.authService.triggerAuthenticationError()
                    }
                }
            }
        }
    }
}
