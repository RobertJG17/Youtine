//
//  Router.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct Router: View {
    @Binding var routines: [Routine?]
    
    @State private var currentPage: Page = .home
    @State var selectedCellIndex: Int? = nil
    @State var selectedRoutine: Routine? = nil
    
    var authService: FirebaseAuthService
    
    init(authService: FirebaseAuthService, routines: Binding<[Routine?]>) {
        self.authService = authService
        self._routines = routines
    }
    
    var body: some View {
        VStack {
            if currentPage == .home {
                HomeView(
                    authService: authService,
                    routines: $routines,
                    selectedCellIndex: $selectedCellIndex
                )
                .onAppear {
                    // MARK: Anytime we nav to home, set selectedCellIndex to nil
                    selectedCellIndex = nil
                    
                    // MARK: And set selectedRoutine to nil
                    selectedRoutine = nil
                }
            } else if currentPage == .routine {
                RoutineView(
                    routine: $selectedRoutine,
                    selectedCellIndex: $selectedCellIndex
                )
            } else if currentPage == .createRoutine || currentPage == .editRoutine {
                ManageRoutineView(
                    routine: $selectedRoutine,
                    selectedCellIndex: $selectedCellIndex
                )
                .transition(.scale)
            }
        }
        .environment(\.currentPage, $currentPage)
        .animation(.easeInOut, value: currentPage)
        .onChange(of: selectedCellIndex) { index, newIndex in
            guard let validIndex = newIndex else { return }
            selectedRoutine = routines[validIndex]
        }
        .background()
    }
}

#Preview {
    Router(
        authService: FirebaseAuthService(),
        routines: .constant(testRoutines)
    )
}
