//
//  CardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardView: View {
    var width: CGFloat
    var height: CGFloat
    var index: Int
    var routine: Youtine?
    var routineCreated: Bool
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
        
    init(
        width: CGFloat,
        height: CGFloat,
        index: Int,
        routine: Youtine?,
        selectedCellIndex: Binding<Int?>
    ) {
        self.width = width
        self.height = height
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
                    width: width,
                    height: height,
                    index: index,
                    routine: routine,
                    selectedCellIndex: $selectedCellIndex
                )
                
            } else {
                EmptyCardView(
                    width: width,
                    height: height,
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
        width: 402.0,
        height: 687.6666666666667,
        index: 1,
        routine: testRoutines[0],
        selectedCellIndex: .constant(1)
    )
}
