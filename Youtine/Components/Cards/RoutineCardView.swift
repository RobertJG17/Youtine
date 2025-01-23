//
//  RoutineCardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct RoutineCardView: View {
    var width: CGFloat
    var height: CGFloat
    var index: Int
    @Binding var selectedCellIndex: Int?
    
    // ???: Properties from routine
    var title: String
    var start: String
    var habits: [Habit]
    var borderColor: Color

    @Environment(\.currentPage) var currentPage

    var habitsCompleted: Int {
        return habits.reduce(0) { partialResult, todo in
            partialResult + (todo.completed ? 1 : 0)
        }
    }
    
    init(
        width: CGFloat,
        height: CGFloat,
        index: Int,
        routine: Youtine?,
        selectedCellIndex: Binding<Int?>
    ) {
        if let validRoutine = routine {
            self.start = validRoutine.start
            self.habits = validRoutine.habits
            self.borderColor = Color.from(description: validRoutine.borderColor)
        } else {
            self.start = ""
            self.habits = []
            self.borderColor = .white
        }
        
        self.width = width
        self.height = height
        self.index = index
        self.title = ManageRoutineView.getRoutineTitle(index: selectedCellIndex.wrappedValue)
                
        self._selectedCellIndex = selectedCellIndex
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: width*0.90, height: height / 4)
                .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                .foregroundStyle(Color.black)
            
            VStack {
                Spacer()
                
                ShortenedHeader(
                    title: title
                )
                
                Divider()
                
                Spacer()
                
                ShortenedDetailView(
                    start: start,
                    habitsCompleted: habitsCompleted,
                    habits: habits
                )
            }
            .padding(50)
            .frame(width: width*0.90, height: height / 4)
            .preferredColorScheme(.dark)
        }
        // MARK: TAPPABLE FRAME [START]
        .frame(width: width*0.90, height: height / 4)
        .background(Color.clear) // Give the Spacer a tappable area
        .contentShape(Rectangle()) // Ensure the entire area is tappable
        // MARK: [END]
        .onTapGesture {
            /// MARK: NAVIGATE TO .routine
            currentPage.wrappedValue = .routine
            
            /// MARK: SET selectedCellIndex index
            selectedCellIndex = index
        }
        .background(Color.black)
    }
}

#Preview {
    RoutineCardView(
        width: 402.0,
        height: 687.66666667,
        index: 0,
        routine: testRoutines[0],
        selectedCellIndex: .constant(0)
    )
}
