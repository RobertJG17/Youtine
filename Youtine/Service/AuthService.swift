//
//  AuthService.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/21/25.
//

import Firebase
import FirebaseAuth
import Combine

@MainActor
class AuthService: ObservableObject {
    // MARK: We implement these functions across our viewModels (Login | Registration)
    // The view models are responsible for invoking the respective functions below
    // and allow us to propogate errors back to our viewModels to handle them within our catch block
    
    var userSession: FirebaseAuth.User?
    
    
    

}
