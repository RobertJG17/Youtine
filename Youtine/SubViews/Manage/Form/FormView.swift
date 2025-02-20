//
//  FormView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct FormView: View {
    @Binding var routineColor: Color
    @Binding var selectedCellIndex: Int?
    @Binding var start: String
    @Binding var selectedDays: [Int: String]
    @Binding var habits: [Habit]
    @Binding var showingCreateHabit: Bool
    @Binding var showingTimePicker: Bool
    @Binding var currentLabel: String
    @Binding var currentDescription: String
    @Binding var currentHabitID: UUID?
    @Binding var hasChanges: Bool
    
    // MARK: Set in onAppear
    @State var routineTitle: String = ""
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    init(
        routineColor: Binding<Color>,
        selectedCellIndex: Binding<Int?>,
        start: Binding<String>,
        selectedDays: Binding<Dictionary<Int, String>>,
        habits: Binding<Array<Habit>>,
        showingCreateHabit: Binding<Bool>,
        showingTimePicker: Binding<Bool>,
        currentLabel: Binding<String>,
        currentDescription: Binding<String>,
        currentHabitID: Binding<UUID?>,
        hasChanges: Binding<Bool>
    ) {
        self._routineColor = routineColor
        self._selectedCellIndex = selectedCellIndex
        self._start = start
        self._selectedDays = selectedDays
        self._habits = habits
        self._showingCreateHabit = showingCreateHabit
        self._showingTimePicker = showingTimePicker
        self._currentLabel = currentLabel
        self._currentDescription = currentDescription
        self._currentHabitID = currentHabitID
        self._hasChanges = hasChanges
    }
    
    var body: some View {
        Form {
            Section(
                header: FormHeaderView(
                    hasChanges: $hasChanges,
                    selectedCellIndex: $selectedCellIndex,
                    routineTitle: routineTitle
                )
            ) {}

            Section(header: Text("Start")) {
                Button {
                    showingTimePicker.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text(start)
                            .frame(width: 105, height: 30)
                            .background(
                                Capsule()
                                    .fill(Color.gray)
                                    .opacity(0.3)
                            )
                            .foregroundStyle(Color.white)
                            .opacity(0.7)
                            .contentShape(Capsule())
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }

            Section(header: Text("Days")) {
                DayPickerView(
                    width: screenWidth.wrappedValue,
                    routineColor: routineColor,
                    selectedDays: $selectedDays
                )
            }
            
            Section(header: Text("Select Color")) {
                CustomColorPicker(
                    width: screenWidth.wrappedValue,
                    height: screenHeight.wrappedValue,
                    routineColor: $routineColor
                )
            }

            Section(header: HStack(alignment: .center) {
                HabitListHeaderView(
                    showingCreateHabit: $showingCreateHabit
                )
            }) {
                HabitListView(
                    habits: $habits,
                    showingCreateHabit: $showingCreateHabit,
                    currentLabel: $currentLabel,
                    currentDesc: $currentDescription,
                    currentHabitID: $currentHabitID
                )
            }
        }
        .onAppear {
            routineTitle = getRoutineTitle(index: selectedCellIndex)
        }
        .scrollContentBackground(.hidden)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

#Preview {
    FormView(
        routineColor: .constant(.white),
        selectedCellIndex: .constant(0),
        start: .constant("8:00 a.m."),
        selectedDays: .constant(Routine.decodeDays(testRoutines[0]!.daysJSON)),
        habits: .constant(testRoutines[0]!.habits),
        showingCreateHabit: .constant(false),
        showingTimePicker: .constant(false),
        currentLabel: .constant(""),
        currentDescription: .constant(""),
        currentHabitID: .constant(UUID()),
        hasChanges: .constant(false)
    )
}
