//
//  HomeView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var routines: [Routine?]
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    
    var authService: FirebaseAuthService
    
    init(authService: FirebaseAuthService, routines: Binding<[Routine?]>, selectedCellIndex: Binding<Int?>) {
        self.authService = authService
        self._routines = routines
        self._selectedCellIndex = selectedCellIndex
    }
    
    var body: some View {
        HeaderView(authService: authService)
        .transition(.move(edge: .leading))
        
        CardsView(
            routines: $routines,
            selectedCellIndex: $selectedCellIndex
        )
        .transition(.move(edge: .leading))
    }
}

#Preview {
    HomeView(
        authService: FirebaseAuthService(),
        routines: .constant(testRoutines),
        selectedCellIndex: .constant(0)
    )
}
