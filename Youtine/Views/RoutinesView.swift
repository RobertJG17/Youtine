//
//  RoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/13/25.
//

import SwiftUI

struct RoutinesView: View {
    @Binding var selectedCellIndex: Int?
    @Binding var createRoutine: Bool
    var routines: [Youtine?]
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        ForEach(Array(routines.enumerated()), id: \.element) { index, routine in
            
            CardView(
                index: index,
                selectedCellIndex: $selectedCellIndex,
                createRoutine: $createRoutine,
                routine: routine,
                height: height,
                width: width
            )
            
            Spacer()
        }
    }
}

#Preview {
    RoutinesView(
        selectedCellIndex: .constant(1),
        createRoutine: .constant(false),
        routines: testRoutines,
        height: 687.6666666666667,
        width: 402.0
    )
}
