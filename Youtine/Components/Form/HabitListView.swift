//
//  HabitListView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct HabitListView: View {
    @Binding var habits: [Habit]
    
    var body: some View {
        List($habits, id: \.id, editActions: .all) { todo in
            let label = todo.label.wrappedValue
            let desc = todo.desc.wrappedValue
        
            VStack(alignment: .leading) {
                Text(label)
                Text(desc)
                    .font(.caption)
                    .fontWeight(.light)
            }
            
        }
    }
}

#Preview {
    HabitListView(habits: .constant(testRoutines[0].habits))
}
