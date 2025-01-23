//
//  Router.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct Router: View {
    var width: CGFloat
    var height: CGFloat
    var routines: [Youtine?]
    
    @State private var currentPage: Page = .home
    @State var selectedCellIndex: Int? = nil
    @State var selectedRoutine: Youtine? = nil
    
    var body: some View {
        VStack {
            if currentPage == .home {
                HomeView(
                    width: width,
                    height: height,
                    routines: routines,
                    selectedCellIndex: $selectedCellIndex
                )
            } else if currentPage == .routine {
                ExpandedRoutineView(
                    width: width,
                    height: height,
                    routine: $selectedRoutine,
                    selectedCellIndex: $selectedCellIndex
                )
            } else if currentPage == .createRoutine || currentPage == .editRoutine {
                ManageRoutineView(
                    width: width,
                    height: height,
                    routine: $selectedRoutine,
                    selectedCellIndex: $selectedCellIndex
                )
                .transition(.scale)
            }
        }
        .padding(.bottom, 40)
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
        width: 402.0,
        height: 687.66666667,
        routines: testRoutines
    )
}
