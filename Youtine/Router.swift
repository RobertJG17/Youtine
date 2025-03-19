//
//  Router.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct Router: View {
    @Binding var routines: [Routine?]
    
    @Environment(RoutineEnvironment.self) var environmentContext
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            if environmentContext.currentPage == .home {
                HomeView(routines: $routines)
                .onAppear {
                    // MARK: Anytime we nav to home, set selectedCellIndex to nil
                    environmentContext.updateSelectedCellIndex(to: nil)
                    
                    // MARK: And set selectedRoutine to nil
                    environmentContext.updateSelectedRoutine(to: nil)
                }
            } else if environmentContext.currentPage == .routine {
                RoutineView()
                .transition(.scale)
            } else if environmentContext.currentPage == .createRoutine ||
                      environmentContext.currentPage == .editRoutine {
                ManageRoutineView(
                    routine: environmentContext.selectedRoutine,
                    selectedCellIndex: environmentContext.selectedCellIndex
                )
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: environmentContext.currentPage)
        .onChange(of: environmentContext.selectedCellIndex) { index, newIndex in
            guard let validIndex = newIndex else { return }
            environmentContext.updateSelectedRoutine(to: routines[validIndex])
        }
        .background()
    }
}

#Preview {
    Router(
        routines: .constant(testRoutines)
    )
}
