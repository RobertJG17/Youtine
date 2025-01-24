//
//  TodoView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedHabitView: View {
    // MARK: Instance Variables
    var habits: [Habit]

    // MARK: Initialized local state
    @State var showScrollIndicator: Bool = true
    @State var animatedOpacity: CGFloat = 1
    
    // MARK: Computed Properties
    var habitsCompleted: Int {
        return habits.reduce(0) { partialResult, habit in
            partialResult + (habit.completed ? 1 : 0)
        }
    }
    
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        VStack(spacing: 0) {
            // Routine title
            HStack(alignment: .center) {
                Text("Tasks")
                    .font(
                        .system(
                            size: 30,
                            weight: .light
                        )
                    )
                Spacer()
            }
            .padding(.leading, 25)
            
            List(habits, id: \.id) { habit in
                let completed = habit.completed
                let desc = habit.desc
                let label = habit.label
                let labelImage = completed ? "checkmark.circle.fill" : "circle"
                
                
                Button {
                    habit.completed.toggle()
                } label: {
                    HStack {
                        Image(systemName: labelImage)
                            .animation(.easeInOut)
                        VStack(alignment: .leading) {
                            Text(label)
                            Text(desc)
                                .font(.caption)
                                .fontWeight(.light)
                        }
                    }
                    .foregroundStyle(Color.white)
                    .padding(.leading, 20)
                    .symbolEffect(
                        .bounce,
                        value: habit.completed
                    )
                    .onAppear{
                        guard let lastHabit: Habit = habits.last else { return }
                        
                        if habit.id == lastHabit.id {
                            showScrollIndicator = false
                        }
                        
                    }
                    .onDisappear {
                        guard let lastHabit: Habit = habits.last else { return }
                        
                        if habit.id == lastHabit.id {
                            showScrollIndicator = true
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(height: screenHeight.wrappedValue/2.3)
            .padding(.leading, 5)
            .padding(.trailing, 20)
            
            VStack {
                HStack{
                    Spacer()
                    Image(systemName: "chevron.down.2")
                        .opacity(
                            showScrollIndicator ?
                            1 : 0
                        )
                        .opacity(animatedOpacity)
                        .padding(.trailing, 20)
                        .animation(
                            .easeInOut(duration: 0.95)
                            .repeatForever(
                                autoreverses: true
                            ),
                            value: animatedOpacity
                        ) // Animate the scale
                        
                        .onAppear {
                            animatedOpacity = 0.75 // Trigger the animation
                        }

                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Completed:")
                        .font(
                            .system(
                                size: 30,
                                weight: .light
                            )
                        )
                        .opacity(0.7)
                    Spacer()
                    Text("\(habitsCompleted)/\(habits.count)")
                        .font(
                            .system(
                                size: 30,
                                weight: .light
                            )
                        )
                        .opacity(0.7)
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 30)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedHabitView(
        habits: testRoutines[0]!.habits
    )
}
