//
//  ExpandedRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct RoutineView: View {
    @Binding var routine: Routine?
    @Binding var selectedCellIndex: Int?
    
    var days: [Int:String]
    var start: String
    var habits: [Habit]
    var borderColor: Color
    
    @State var routineTitle: String = ""

    @Environment(\.deleteRoutineFromDisk) var deleteRoutineFromDisk
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    init(
        routine: Binding<Routine?>,
        selectedCellIndex: Binding<Int?>
    ) {
        self._routine = routine
        self._selectedCellIndex = selectedCellIndex
        
        self.days = Routine.decodeDays(
            routine.wrappedValue?.daysJSON ?? ""
        )
        self.start = routine.wrappedValue?.start ?? ""
        self.habits = routine.wrappedValue?.habits ?? []
        self.borderColor = Color.from(
            description: routine.wrappedValue?.borderColor ?? "white"
        )
    }
    
    // MARK: DELETE FUNCTIONALITY
    func handleDeleteRoutine() -> Void {
        do {
            if let validRoutine = self.routine {
                try deleteRoutineFromDisk(validRoutine)
            }
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            RoutineHeaderView(
                title: routineTitle,
                selectedCellIndex: $selectedCellIndex
            )
            
            VStack(spacing: 0) {
                RoutineDetailView(
                    start: start,
                    routine: $routine,
                    selectedCellIndex: $selectedCellIndex
                )
                Spacer()
                
                RoutineHabitView(
                    habits: habits
                )
            }
            .overlay(
                Image(backgroundImage)
                    .resizable()
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .horizontal)
                    .frame(height: screenHeight.wrappedValue)
            )
            .overlay(
                VStack {
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                    Spacer()
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                }
                    .frame(height: screenHeight.wrappedValue)
            )
            .frame(height: screenHeight.wrappedValue)
            .padding(.bottom, 10)
            .preferredColorScheme(.dark)
        }
        .onAppear {
            routineTitle = getRoutineTitle(index: selectedCellIndex)
            
        }
        .environment(\.handleDeleteRoutine, handleDeleteRoutine)
        .frame(
            width: screenWidth.wrappedValue,
            height: screenHeight.wrappedValue
        )
        .transition(.scale)
    }
}

#Preview {
    RoutineView(
        routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
