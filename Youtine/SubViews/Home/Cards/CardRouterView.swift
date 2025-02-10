//
//  CardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardRouterView: View {
    var index: Int
    var routine: Routine?
    var routineCreated: Bool
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
        
    init(
        index: Int,
        routine: Routine?,
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
    CardRouterView(
        index: 1,
        routine: testRoutines[0],
        selectedCellIndex: .constant(1)
    )
}
