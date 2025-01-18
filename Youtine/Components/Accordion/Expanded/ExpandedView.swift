//
//  OpenView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ExpandedView: View {
    var index: Int
    @Binding var selectedCellIndex: Int?
    var title: String
    var days: [String]
    var start: String
    var habits: [Habit]
    var height: CGFloat
    var borderColor: Color

    init(
        index: Int,
        selectedCellIndex: Binding<Int?>,
        routine: Youtine,
        height: CGFloat
    ) {
        self.index = index
        self._selectedCellIndex = selectedCellIndex
        self.title = routine.title
        self.days = routine.days
        self.start = routine.start
        self.habits = routine.habits
        self.borderColor = Color.from(description: routine.borderColor)
        self.height = height
    }
    
    var body: some View {
        VStack {
            ExpandedHeader(
                title: title,
                selectedCellIndex: $selectedCellIndex
            )
                
            VStack(spacing: 0) {
                ExpandedDetailView(
                    start: start
                )
                
                Spacer()
                
                HabitView(
                    habits: habits,
                    height: height
                )
            }
            
            .overlay(
                Image(backgroundImage)
                    .resizable()
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .horizontal)
                    .frame(height: height*0.85)
            )
            .overlay(
                VStack {
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                    Spacer()
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                }
                    .frame(height: height*0.85)
            )
            .frame(height: height*0.85)
            .preferredColorScheme(.dark)
            
        }
    }
    
}

#Preview {
    ExpandedView(
        index: 0,
        selectedCellIndex: .constant(0),
        routine: testRoutines[0],
        height: 687.6666666666667
    )
}
