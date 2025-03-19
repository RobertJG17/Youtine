//
//  RoutineCardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct RoutineCardView: View {
    var index: Int
    
    // ???: Properties from routine
    var title: String
    var start: String
    var habits: [Habit]
    var borderColor: Color

    @Environment(RoutineEnvironment.self) var environmentContext

    var habitsCompleted: Int {
        return habits.reduce(0) { partialResult, todo in
            partialResult + (todo.completed ? 1 : 0)
        }
    }
    
    init(
        index: Int,
        routine: Routine?
    ) {
        if let validRoutine = routine {
            self.start = validRoutine.start
            self.habits = validRoutine.habits
            self.borderColor = Color.from(description: validRoutine.color)
        } else {
            self.start = ""
            self.habits = []
            self.borderColor = .white
        }
        
        self.index = index
        self.title = getRoutineTitle(index: index)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    width: environmentContext.screenWidth*0.90,
                    height: environmentContext.screenHeight / 4
                )
                .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                .foregroundStyle(Color.black)
            
            VStack {
                Spacer()
                
                CardHeaderView(
                    title: title
                )
                
                Divider()
                
                Spacer()
                
                CardDetailView(
                    start: start,
                    habitsCompleted: habitsCompleted,
                    habits: habits
                )
            }
            .padding(50)
            .frame(
                width: environmentContext.screenWidth*0.90,
                height: environmentContext.screenHeight / 4
            )
            .preferredColorScheme(.dark)
        }
        // MARK: TAPPABLE FRAME [START]
        .frame(
            width: environmentContext.screenWidth*0.90,
            height: environmentContext.screenHeight / 4
        )
        .background(Color.clear) // Give the Spacer a tappable area
        .contentShape(Rectangle()) // Ensure the entire area is tappable
        // MARK: [END]
        .onTapGesture {
            // MARK: NAVIGATE TO .routine
            environmentContext.updatePage(to: .routine)
                        
            // MARK: SET selectedCellIndex
            environmentContext.updateSelectedCellIndex(to: index)
        }
        .background(Color.black)
    }
}

#Preview {
    RoutineCardView(
        index: 0,
        routine: testRoutines[0]
    )
}
