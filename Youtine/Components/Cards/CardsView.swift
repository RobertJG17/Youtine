//
//  CardsView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct CardsView: View {
    @Binding var routines: [Youtine?]
    @Binding var selectedCellIndex: Int?

    var body: some View {
        ForEach(Array(routines.enumerated()), id: \.offset) { index, routine in
            CardView(
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
        routines: .constant(testRoutines),
        selectedCellIndex: .constant(1)
    )
}
