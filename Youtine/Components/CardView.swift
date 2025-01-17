//
//  CardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct CardView: View {
    var index: Int
    var selectedCellIndex: Int?
    var title: String
    var start: String
    var todos: [Todo]
    var height: CGFloat
    var borderColor: String
    
    var body: some View {
        Group {
            if selectedCellIndex == nil {
                ShortenedView(
                    index: index,
                    title: title,
                    start: start,
                    todos: todos,
                    height: height,
                    borderColor: borderColor
                )
            } else if (selectedCellIndex != nil) && selectedCellIndex == index {
                ExpandedView(
                    index: index,
                    title: title,
                    start: start,
                    todos: todos,
                    height: height,
                    borderColor: borderColor
                )
            }
        }        
    }
}

#Preview {
    CardView(
        index: 0,
        selectedCellIndex: 0,
        title: "Morning Routine",
        start: "8:00 a.m.",
        todos: testRoutines[0].todos,
        height: 500,
        borderColor: "red"
    )
}
