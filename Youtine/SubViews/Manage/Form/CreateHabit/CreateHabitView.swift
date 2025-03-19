//
//  RoutineInitView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct CreateHabitView: View {
    @Binding var habits: [Habit]
    @Binding var showingCreateHabit: Bool
    @Binding var label: String
    @Binding var desc: String
    @Binding var id: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                CreateHabitToolbarView(
                    habits: $habits,
                    showingCreateHabit: $showingCreateHabit,
                    label: $label,
                    desc: $desc,
                    id: $id
                )
                
                Spacer()
                          
                // TODO: Create expanded and closed view (see if swift ui has accordion like view)
                HStack(alignment: .bottom) {
                    Text("Label: ")
                        .font(.system(size: 30, weight: .thin))
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 2.5) {
                        TextField(text: $label) {}
                            .frame(width: 230, alignment: .center)
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: 217, height: 1)
                            .padding(.trailing, 15)
                    }
                    .font(.system(size: 28, weight: .thin))
                }
                
                HStack(alignment: .top) {
                    Text("Description: ")
                        .font(.system(size: 20, weight: .thin))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        TextEditor(text: $desc)    // Multiline text input
                            .frame(height: 150)    // Set a height for the TextEditor
                            .border(Color.gray, width: 1)   // Optional: Add a border
                            .padding()
                    }
                    .font(.system(size: 18, weight: .thin))
                }
                
                Spacer()
            }
            .padding(20)
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CreateHabitView(
        habits: .constant([]),
        showingCreateHabit: .constant(true),
        label: .constant("label"),
        desc: .constant("desc"),
        id: .constant(UUID())
    )
}
