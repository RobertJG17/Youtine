//
//  HabitListItems.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/26/25.
//

import SwiftUI
import Combine

struct RoutineHabitListView: View {
    var habits: [Habit]
    @Binding var canScroll: Bool?
    @Binding var showScrollIndicator: Bool
    
    @State var animatedOpacity: CGFloat = 1
    @State var disclosureExpansionLocked: Bool = false
    
    @Environment(RoutineEnvironment.self) var environmentContext
    
    var body: some View {
        ScrollViewReader { proxy in
            List(habits, id: \.id) { habit in
                let labelImage = habit.completed ? "checkmark.circle.fill" : "circle"
                let labelImageColor = habit.completed ? Color.green : Color.white
                
                HStack {
                    Button {
                        habit.completed.toggle()
                    } label: {
                        Image(systemName: labelImage)
                            .animation(.easeInOut)
                            .foregroundStyle(labelImageColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .contentShape(Rectangle())
                    .symbolEffect(
                        .bounce,
                        value: habit.completed
                    )
                    .frame(
                        width: 50
                    )
                    .frame(maxHeight: .infinity)
//                    .border(Color.red) MARK: DEBUG
                    
                    Divider()
                        .padding(.leading, -5)
                    
                    HabitListDisclosureGroupView(
                        label: habit.label,
                        desc: habit.desc,
                        disclosureExpansionLocked: $disclosureExpansionLocked
                    )
//                    .border(Color.green) MARK: DEBUG
                }
//                .border(Color.yellow) MARK: DEBUG
                .onAppear {
                    guard let lastHabit: Habit = habits.last else { return }
                    
                    if habit.id == lastHabit.id {
                        showScrollIndicator = false
                        canScroll = false
                    }
                }
                .onDisappear {
                    guard let lastHabit: Habit = habits.last else { return }
                    
                    if habit.id == lastHabit.id {
                        showScrollIndicator = true
                    }
                }
                .contentShape(Rectangle())
            }
            .listStyle(PlainListStyle())
//            .border(Color.orange) MARK: DEBUG
            .onReceive(Just(canScroll), perform: { _ in
                if let scroll = canScroll, scroll == true {
                    guard let lastHabit = habits.last else { return }
                    
                    withAnimation {
                        proxy.scrollTo(lastHabit.id, anchor: .bottom)
                    }
                }
            })
        }
        .padding(.leading, 5)
        .padding(.trailing, 20)
        .frame(height: environmentContext.screenHeight / 2.3)
    }
}

#Preview {
    RoutineHabitListView(
        habits: testRoutines[0]!.habits,
        canScroll: .constant(false),
        showScrollIndicator: .constant(false)
    )
}
