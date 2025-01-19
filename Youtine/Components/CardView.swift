//
//  CardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardView: View {
    var index: Int
    
    // MARK: Bool control 1
    @Binding var selectedCellIndex: Int?
    @Binding var createRoutine: Bool
    var routine: Youtine?
    var height: CGFloat
    var width: CGFloat
    
    // MARK: Bool control 2
   
    
    // ???: The boolean controls handle the control
    // ???: flow for the UI as these vars change
    // ???:
    
    var body: some View {
        ZStack {
            if selectedCellIndex == nil
            {
                ShortenedView(
                    index: index,
                    selectedCellIndex: $selectedCellIndex,
                    createRoutine: $createRoutine,
                    routine: routine,
                    height: height,
                    width: width
                )
                .transition(
                    .asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    )
                )
            } else if
                selectedCellIndex != nil
                && selectedCellIndex == index
                && routine != nil
                && !createRoutine
            {
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
            } else if
                selectedCellIndex != nil
                && selectedCellIndex == index
                && createRoutine
            {
                CreateRoutineView(
                    index: index,
                    selectedCellIndex: $selectedCellIndex,
                    width: width,
                    height: height,
                    createRoutine: $createRoutine
                )
                .transition(
                    .asymmetric(
                        insertion: .scale,
                        removal: .scale
                    )
                )
            }
        }
        .animation(.easeInOut, value: selectedCellIndex)
    }
}

#Preview {
    CardView(
        index: 1,
        selectedCellIndex: .constant(1), createRoutine: .constant(false),
        routine: testRoutines[0],
        height: 687.6666666666667,
        width: 402.0
    )
}
