//
//  RoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/13/25.
//

import SwiftUI

struct RoutinesView: View {
    @Binding var selectedCellIndex: Int?
    var routines: [Youtine]
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        ForEach(Array(routines.enumerated()), id: \.element) { index, routine in
            CardView(
                index: index,
                selectedCellIndex: $selectedCellIndex,
                routine: routine,
                height: height,
                width: width
            )
            
            if selectedCellIndex == nil {
                Spacer()
            } else if (selectedCellIndex != nil) &&
                        selectedCellIndex == index {
                Spacer()
            }
        }
    }
}

#Preview {
    RoutinesView(
        selectedCellIndex: .constant(1),
        routines: testRoutines,
        height: 687.6666666666667,
        width: 402.0
    )
}
