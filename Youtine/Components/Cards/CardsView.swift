//
//  CardsView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct CardsView: View {
    var width: CGFloat
    var height: CGFloat
    @Binding var routines: [Youtine?]
    @Binding var selectedCellIndex: Int?

    var body: some View {
        ForEach(Array(routines.enumerated()), id: \.offset) { index, routine in
            CardView(
                width: width,
                height: height,
                index: index,
                routine: routine,
                selectedCellIndex: $selectedCellIndex
            )
            
            Spacer()
        }
    }
}

#Preview {
    CardsView(
        width: 402.0,
        height: 687.6666666666667,
        routines: .constant(testRoutines),
        selectedCellIndex: .constant(1)
    )
}
