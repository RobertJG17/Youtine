//
//  CardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardView: View {
    var index: Int
    var routine: Youtine?
    var routineCreated: Bool
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
        
    init(
        index: Int,
        routine: Youtine?,
        selectedCellIndex: Binding<Int?>
    ) {
        self.index = index
        self.routine = routine
        self.routineCreated = routine != nil
        self._selectedCellIndex = selectedCellIndex
    }
    
    var body: some View {
        // card start
        ZStack {
            if routineCreated {
                RoutineCardView(
                    index: index,
                    routine: routine,
                    selectedCellIndex: $selectedCellIndex
                )
            } else {
                EmptyCardView(
                    index: index,
                    borderColor: Color.white,
                    selectedCellIndex: $selectedCellIndex
                )
            }
        }
        .animation(.easeInOut, value: currentPage.wrappedValue)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CardView(
        index: 1,
        routine: testRoutines[0],
        selectedCellIndex: .constant(1)
    )
}
