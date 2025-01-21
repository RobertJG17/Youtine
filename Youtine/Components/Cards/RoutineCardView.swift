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
    
    // ???: Properties from routine
    var title: String
    var start: String
    var habits: [Habit]
    var borderColor: Color
    var routineCreated: Bool
    
    @Binding var selectedCellIndex: Int?

    @Environment(\.currentPage) var currentPage
    
    // MARK: Computed Properties
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
        self.width = width
        self.height = height
        self.index = index
        
        self.title = routine?.title ?? ""
        self.start = routine?.start ?? ""
        self.habits = routine?.habits ?? []
        self.borderColor = Color.from(
            description: routine?.borderColor ?? "white"
        )
        self.routineCreated = routine != nil
        
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
            // MARK: selectedCellIndex set
            selectedCellIndex = index
            
            // MARK: Navigate to routine
            currentPage.wrappedValue = .routine
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
