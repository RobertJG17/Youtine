//
//  TodoView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedHabitListView: View {
    // MARK: Instance Variables
    var habits: [Habit]

    // MARK: Initialized local state
    @State var showScrollIndicator: Bool = true
    @State var animatedOpacity: CGFloat = 1
    @State var canScroll: Bool? = nil
    
    var habitsCompleted: Int {
        return habits.reduce(0) { partialResult, habit in
            partialResult + (habit.completed ? 1 : 0)
        }
    }
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        VStack(spacing: 0) {
            // Routine title
            HStack(alignment: .center) {
                Text("Habits")
                    .font(
                        .system(
                            size: 30,
                            weight: .light
                        )
                    )
                Spacer()
            }
            .padding(.leading, 25)
            
            Rectangle()
                .frame(width: screenWidth.wrappedValue*0.9, height: 0.2)
                .padding(.horizontal, 20)
                .padding(.top, 15)
        
            RoutineHabitListView(
                habits: habits,
                canScroll: $canScroll,
                showScrollIndicator: $showScrollIndicator
            )
            
            VStack {
                HStack{
                    Spacer()
                    if !habits.isEmpty {
                        Button {
                            canScroll = true
                        } label: {
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
                                    value: animatedOpacity // Animate the scale
                                )
                                
                                .onAppear {
                                    animatedOpacity = 0.75 // Trigger the animation
                                }
                        }
                        .foregroundStyle(Color.white)
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
    ExpandedHabitListView(
        habits: testRoutines[0]!.habits
    )
}
