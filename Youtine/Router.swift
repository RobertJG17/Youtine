//
//  Router.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct Router: View {
    @Binding var routines: [Youtine?]
    
    @State private var currentPage: Page = .home
    @State var selectedCellIndex: Int? = nil
    @State var selectedRoutine: Youtine? = nil
    
    var body: some View {
        VStack {
            if currentPage == .home {
                HomeView(
                    routines: $routines,
                    selectedCellIndex: $selectedCellIndex
                )
                .onAppear {
                    /// MARK: Anytime we nav to home,
                    /// ensure selected routine and selected cell index are nil
                    selectedCellIndex = nil
                    selectedRoutine = nil
                }
            } else if currentPage == .routine {
                ExpandedRoutineView(
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
