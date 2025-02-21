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
    
    var body: some View {
        VStack {
            if currentPage == .home {
                HomeView(
                    routines: $routines,
                    selectedCellIndex: $selectedCellIndex
                )
                .onAppear {
                    // MARK: Anytime we nav to home, set selected routine to nil
                    selectedCellIndex = nil
                    
                    // MARK: And selected cell index are nil
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
        .onChange(of: selectedCellIndex, { index, newIndex in
            guard let validIndex = newIndex else { return }
            selectedRoutine = routines[validIndex]
        })
        .background()
    }
}

#Preview {
    Router(
        routines: .constant(testRoutines)
    )
}
