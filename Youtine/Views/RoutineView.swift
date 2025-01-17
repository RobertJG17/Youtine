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
        CardView(
            index: index,
            selectedCellIndex: $selectedCellIndex,
            routine: routine,
            height: height
        )
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
