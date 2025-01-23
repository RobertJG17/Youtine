//
//  FormView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct FormView: View {
    var width: CGFloat
    var height: CGFloat
    @Binding var selectedCellIndex: Int?
    @Binding var start: String
    @Binding var selectedDays: [Int: String]
    @Binding var habits: [Habit]
    
    @Binding var showingRoutineInit: Bool
    @Binding var showingTimePicker: Bool
    
    // MARK: Set in onAppear
    @State var routineColor: Color = Color.white
    @State var routineTitle: String = ""
    
    
    init(
        width: CGFloat,
        height: CGFloat,
        selectedCellIndex: Binding<Int?>,
        start: Binding<String>,
        selectedDays: Binding<Dictionary<Int, String>>,
        habits: Binding<Array<Habit>>,
        showingRoutineInit: Binding<Bool>,
        showingTimePicker: Binding<Bool>
        
    ) {
        self.width = width
        self.height = height
        self._selectedCellIndex = selectedCellIndex
        self._start = start
        self._selectedDays = selectedDays
        self._habits = habits
        self._showingRoutineInit = showingRoutineInit
        self._showingTimePicker = showingTimePicker
    }
    
    var body: some View {
        Form {
            Section(
                header: FormHeaderView(
                    routineTitle: routineTitle,
                    selectedCellIndex: $selectedCellIndex
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
                    width: width,
                    routineColor: routineColor,
                    selectedDays: $selectedDays
                )
            }
            
            Section(header: Text("Select Color")) {
                CustomColorPicker(
                    width: width,
                    height: height,
                    routineColor: $routineColor
                )
                
            }

            Section(header: HStack(alignment: .center) {
                HabitHeaderView(
                    showingRoutineInit: $showingRoutineInit
                )
            }) {
                HabitListView(
                    habits: $habits
                )
            }
        }
        .onAppear {
            routineTitle = ManageRoutineView.getRoutineTitle(index: selectedCellIndex)
        }
        .scrollContentBackground(.hidden)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

//#Preview {
//    FormView(
//        width: 402.0,
//        height: 687.666667,
//        selectedCellIndex: .constant(0),
//        routines: .constant(testRoutines),
//        start: .constant("8:00 a.m."),
//        selectedDays: .constant(testRoutines[0]!.days),
//        habits: .constant(testRoutines[0]!.habits),
//        showingRoutineInit: .constant(false),
//        showingTimePicker: .constant(false)
//    )
//}
