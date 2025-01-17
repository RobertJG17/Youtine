//
//  RoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/13/25.
//

import SwiftUI

struct RoutineView: View {
    var index: Int
    @Binding var selectedCellIndex: Int?
    var routine: Youtine
    var height: CGFloat
    
    var body: some View {
        ZStack {
            if selectedCellIndex == nil {
                ShortenedView(
                    index: index,
                    selectedCellIndex: $selectedCellIndex,
                    routine: routine,
                    height: height
                )
                .transition(
                    .asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    )
                )
            } else if (selectedCellIndex != nil) && selectedCellIndex == index {
                ExpandedView(
                    index: index,
                    selectedCellIndex: $selectedCellIndex,
                    routine: routine,
                    height: height
                )
                .transition(
                    .asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    )
                )
            }
        }
        .animation(.easeInOut, value: selectedCellIndex)
    }
}

#Preview {
    RoutineView(
        index: 1,
        selectedCellIndex: .constant(1),
        routine: testRoutines[0],
        height: 687.6666666666667
    )
}
