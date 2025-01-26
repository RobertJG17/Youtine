//
//  HabitListItems.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/26/25.
//

import SwiftUI
import Combine

struct HabitListItems: View {
    var habits: [Habit]
    @Binding var canScroll: Bool?
    @Binding var showScrollIndicator: Bool
    
    @State var animatedOpacity: CGFloat = 1
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        ScrollViewReader { proxy in
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
                                .lineLimit(1) // Set the number of lines to display
                                .truncationMode(.tail) // Use ellipsis for overflow
                        }
                    }
                    .foregroundStyle(Color.white)
                    .symbolEffect(
                        .bounce,
                        value: habit.completed
                    )
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
                }
            }
            .listStyle(PlainListStyle())
            .padding(.leading, 5)
            .padding(.trailing, 20)
            .frame(height: screenHeight.wrappedValue / 2.3)
            .onReceive(Just(canScroll), perform: { _ in
                if let scroll = canScroll, scroll == true {
                    guard let lastHabit = habits.last else { return }
                    
                    withAnimation {
                        proxy.scrollTo(lastHabit.id, anchor: .bottom)
                    }
                }
            })
        }
    }
}

#Preview {
    HabitListItems(
        habits: testRoutines[0]!.habits,
        canScroll: .constant(false),
        showScrollIndicator: .constant(false)
    )
}
