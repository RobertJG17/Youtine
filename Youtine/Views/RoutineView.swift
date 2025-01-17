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
    var title: String
    var start: String
    var todos: [Todo]
    var height: CGFloat
    var borderColor: String
    
    var body: some View {
        Button {
            if selectedCellIndex != nil {
                selectedCellIndex = nil
            } else {
                selectedCellIndex = index
            }
        } label: {
            CardView(
                index: index,
                selectedCellIndex: selectedCellIndex,
                title: title,
                start: start,
                todos: todos,
                height: height,
                borderColor: borderColor
            )
        }
        .foregroundStyle(Color.white)

        
    }
}

#Preview {
    RoutineView(
        index: 1,
        selectedCellIndex: .constant(1),
        title: "Morning Routine",
        start: "8:00 am",
        todos: testRoutines[0].todos,
        height: 600,
        borderColor: "red"
    )
}
