//
//  HabitToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct HabitListHeaderView: View {
    @Binding var showingCreateHabit: Bool
    
    let HEADER_TITLE: String = "Habits"
    let TOOLBAR_ADD_SYSTEM_NAME: String = "plus"
    
    var body: some View {
        Text(HEADER_TITLE)
        
        Spacer()
        
        // ???: Add Habit Button
        Button {
            showingCreateHabit = true
        } label: {
            Image(systemName: TOOLBAR_ADD_SYSTEM_NAME)
        }
        .font(.system(size: 18))
    }
}

#Preview {
    HabitListHeaderView(
        showingCreateHabit: .constant(true)
    )
}
