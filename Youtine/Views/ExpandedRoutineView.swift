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
    @Binding var routine: Youtine?
    @Binding var selectedCellIndex: Int?
    
    var days: [Int:String]
    var start: String
    var habits: [Habit]
    var borderColor: Color
    
    @State var routineTitle: String = ""

    @Environment(\.deleteRoutineFromDisk) var deleteRoutineFromDisk
    @Environment(\.contextViewModel) var contextViewModel
    
    init(
        width: CGFloat,
        height: CGFloat,
        routine: Binding<Youtine?>,
        selectedCellIndex: Binding<Int?>
    ) {
        self.width = width
        self.height = height
        self._routine = routine
        self._selectedCellIndex = selectedCellIndex
        
        self.days = Youtine.decodeDays(
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
                try deleteRoutineFromDisk(
                    validRoutine,
                    contextViewModel
                )
            }
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            ExpandedHeader(
                height: height,
                title: routineTitle,
                selectedCellIndex: $selectedCellIndex
            )
            
            VStack(spacing: 0) {
                ExpandedDetailView(
                    start: start,
                    routine: $routine,
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
        .onAppear {
            routineTitle = ManageRoutineView.getRoutineTitle(index: selectedCellIndex)
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
        routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
