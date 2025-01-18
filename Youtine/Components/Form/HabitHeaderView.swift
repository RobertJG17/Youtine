//
//  HabitToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct HabitHeaderView: View {
    @Binding var showingRoutineInit: Bool
    
    let HEADER_TITLE: String = "Habits"
    let TOOLBAR_ADD_SYSTEM_NAME: String = "plus"
    
    var body: some View {
        Text(HEADER_TITLE)
        
        Spacer()
        
        // ???: Add Habit Button
        Button {
            showingRoutineInit = true
        } label: {
            Image(systemName: TOOLBAR_ADD_SYSTEM_NAME)
        }
        .font(.system(size: 18))
    }
}

#Preview {
    HabitHeaderView(
        showingRoutineInit: .constant(true)
    )
}
