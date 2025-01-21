//
//  ExpandedRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct ExpandedRoutineView: View {
    var width: CGFloat
    var height: CGFloat
    var routines: [Youtine?]
    var selectedRoutine: Youtine?
    @Binding var selectedCellIndex: Int?
    
    var body: some View {
        VStack {
            ExpandedHeader(
                height: height,
                routine: selectedRoutine,
                selectedCellIndex: $selectedCellIndex
            )
            ExpandedView(
                height: height,
                routine: selectedRoutine,
                selectedCellIndex: $selectedCellIndex
            )
        }
        .frame(
            width: width,
            height: height*0.82
        )
        .transition(.scale)
    }
}

#Preview {
    ExpandedRoutineView(
        width: 402.2,
        height: 687.6666666667,
        routines: testRoutines,
        selectedRoutine: testRoutines[0],
        selectedCellIndex: .constant(0)
    )
}
