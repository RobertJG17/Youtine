//
//  ExpandedRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct ExpandedRoutineView: View {
    var width: CGFloat
    var height: CGFloat
    @Binding var selectedCellIndex: Int?
    @Binding var routines: [Youtine?]
    
    var routine: Youtine?
    
    var title: String
    var days: [Int:String]
    var start: String
    var habits: [Habit]
    var borderColor: Color

    @Environment(\.deleteRoutineFromDisk) var deleteRoutineFromDisk
    @Environment(\.contextViewModel) var contextViewModel
    
    init(
        width: CGFloat,
        height: CGFloat,
        routine: Youtine?,
        routines: Binding<[Youtine?]>,
        selectedCellIndex: Binding<Int?>
    ) {
        self.width = width
        self.height = height
        self.title = ManageRoutineView.getRoutineTitle(index: selectedCellIndex.wrappedValue!)
        self.days = Youtine.decodeDays(routine?.daysJSON ?? "")
        self.start = routine?.start ?? ""
        self.habits = routine?.habits ?? []
        self.borderColor = Color.from(description: routine?.borderColor ?? "white")
        self.routine = routine
        self._routines = routines
        self._selectedCellIndex = selectedCellIndex
    }
    
    // MARK: DELETE FUNCTIONALITY
    func handleDeleteRoutine() -> Void {
        do {
            if let validRoutine = self.routine {
                handleSetRoutineToNil()
                try deleteRoutineFromDisk(validRoutine, contextViewModel)
            }
        } catch {
            print(error)
        }
    }
    
    func handleSetRoutineToNil() -> Void {
        if let validIndex = selectedCellIndex {
            routines[validIndex] = nil
        }
    }
    
    var body: some View {
        VStack {
            ExpandedHeader(
                height: height,
                routine: routine,
                selectedCellIndex: $selectedCellIndex
            )
            
            VStack(spacing: 0) {
                ExpandedDetailView(
                    start: start,
                    selectedCellIndex: $selectedCellIndex
                )
                
                ExpandedHabitView(
                    habits: habits,
                    height: height
                )
            }
            
            .overlay(
                Image(backgroundImage)
                    .resizable()
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .horizontal)
                    .frame(height: height*0.82)
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
                    .frame(height: height*0.82)
            )
            .frame(height: height*0.82)
            .padding(.top, 15)
            .padding(.bottom, 30)
            .preferredColorScheme(.dark)
        }
        .environment(\.handleDeleteRoutine, handleDeleteRoutine)
        .frame(
            width: width,
            height: height*0.82
        )
        .transition(.scale)
    }
}

#Preview {
    ExpandedRoutineView(
        width: 402.2,
        height: 687.6666666667,
        routine: testRoutines[0],
        routines: .constant(testRoutines),
        selectedCellIndex: .constant(0)
    )
}
