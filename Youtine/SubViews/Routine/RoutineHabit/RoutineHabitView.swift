//
//  TodoView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct RoutineHabitView: View {
    // MARK: Instance Variables
    var habits: [Habit]

    // MARK: Initialized local state
    @State var showScrollIndicator: Bool = true
    @State var canScroll: Bool? = nil
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        VStack(spacing: 0) {
            RoutineHabitHeaderView()
            
            Rectangle()
                .frame(width: screenWidth.wrappedValue*0.9, height: 0.3)
                .padding(.horizontal, 20)
                .padding(.top, 15)
        
            RoutineHabitListView(
                habits: habits,
                canScroll: $canScroll,
                showScrollIndicator: $showScrollIndicator
            )
            
            RoutineHabitFooterView(
                habits: habits,
                showScrollIndicator: showScrollIndicator,
                canScroll: $canScroll
            )
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoutineHabitView(
        habits: testRoutines[0]!.habits
    )
}
