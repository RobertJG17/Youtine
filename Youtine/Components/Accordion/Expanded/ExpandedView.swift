//
//  OpenView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ExpandedView: View {
    var title: String
    var days: [Int:String]
    var start: String
    var habits: [Habit]
    var height: CGFloat
    var borderColor: Color
    
    @Binding var selectedCellIndex: Int?

    init(
        height: CGFloat,
        routine: Youtine?,
        selectedCellIndex: Binding<Int?>
    ) {
        self.height = height
        self.title = routine?.title ?? ""
        self.days = Youtine.decodeDays(routine?.daysJSON ?? "")
        self.start = routine?.start ?? ""
        self.habits = routine?.habits ?? []
        self.borderColor = Color.from(description: routine?.borderColor ?? "white")
        self._selectedCellIndex = selectedCellIndex
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ExpandedDetailView(
                start: start
            )
            
            ExpandedHabitView(
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
                .frame(height: height*0.82)
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
                .frame(height: height*0.82)
        )
        .frame(height: height*0.82)
        .padding(.top, 15)
        .padding(.bottom, 30)
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    ExpandedView(
        height: 687.6666666666667,
        routine: testRoutines[0],
        selectedCellIndex: .constant(0)
    )
}
