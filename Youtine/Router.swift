//
//  Router.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct Router: View {
    @Binding var routines: [Routine?]
    
    @Environment(UIStore.self) var uiStore
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            if uiStore.currentPage == .home {
                HomeView(routines: $routines)
                .onAppear {
                    // MARK: Anytime we nav to home, set selectedCellIndex to nil
                    uiStore.updateSelectedCellIndex(to: nil)
                    
                    // MARK: And set selectedRoutine to nil
                    uiStore.updateSelectedRoutine(to: nil)
                }
            } else if uiStore.currentPage == .routine {
                RoutineView()
                .transition(.scale)
            } else if uiStore.currentPage == .createRoutine ||
                      uiStore.currentPage == .editRoutine {
                ManageRoutineView(
                    routine: uiStore.selectedRoutine,
                    selectedCellIndex: uiStore.selectedCellIndex
                )
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: uiStore.currentPage)
        .onChange(of: uiStore.selectedCellIndex) { index, newIndex in
            guard let validIndex = newIndex else { return }
            uiStore.updateSelectedRoutine(to: routines[validIndex])
        }
        .background()
    }
}

#Preview {
    Router(
        routines: .constant(testRoutines)
    )
}
