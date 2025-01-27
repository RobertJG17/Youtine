//
//  RoutineHabitFooterView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/27/25.
//

import SwiftUI

struct RoutineHabitFooterView: View {
    var habits: [Habit]
    var showScrollIndicator: Bool
    @Binding var canScroll: Bool?
    
    @State var animatedOpacity: CGFloat = 1
    
    var habitsCompleted: Int {
        return habits.reduce(0) { partialResult, habit in
            partialResult + (habit.completed ? 1 : 0)
        }
    }
    
    func getRoutineScoreColor() -> Color {
        guard habits.count != 0 else { return Color.white }
        
        var color = Color.white
        let score = Double(habitsCompleted)/Double(habits.count)
                
        if score >= 0.0 && score < 0.33333 {
            color = Color.red
        } else if score >= 0.33333 && score < 0.66666 {
            color = Color.orange
        } else if score >= 0.66666 && score < 0.8 {
            color = Color.yellow
        } else if score >= 0.8 {
            color = Color.green
        }
        
        return color
    }
    
    var body: some View {
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
                            .padding(.top, 8)
                            .animation(
                                .easeInOut(duration: 0.55)
                                .repeatForever(
                                    autoreverses: true
                                ),
                                value: animatedOpacity // Animate the scale
                            )
                            
                            .onAppear {
                                animatedOpacity = 0.35 // Trigger the animation
                            }
                    }
                    .foregroundStyle(Color.white)
                }
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 8)
            
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
                    .foregroundStyle(getRoutineScoreColor())
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.bottom, 45)
        }
    }
}

#Preview {
    RoutineHabitFooterView(
        habits: testRoutines[0]!.habits,
        showScrollIndicator: false,
        canScroll: .constant(false)
    )
}
