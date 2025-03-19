//
//  CardsView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct CardsView: View {
    @Binding var routines: [Routine?]

    var body: some View {
        ForEach(Array(routines.enumerated()), id: \.offset) { index, routine in
            CardRouterView(
                index: index,
                routine: routine
            )
            
            Spacer()
        }
    }
}

#Preview {
    CardsView(
        routines: .constant(testRoutines)
    )
}
