//
//  ExpandedRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct RoutineView: View {
    @State var days: [Int:String] = [:]
    @State var start: String = "8:00 AM"
    @State var habits: [Habit] = []
    @State var borderColor: Color = .white
    @State var routineTitle: String = ""
    @State var backgroundImage: String = "morning"

    @Environment(RoutineEnvironment.self) var environmentContext
    @Environment(\.modelContext) var context
    
    var dataManagerService: DataManagerService {
        DataManagerService(context: context)
    }
    
    // MARK: DELETE FUNCTIONALITY
    func handleDeleteRoutine() -> Void {
        if let routine = environmentContext.selectedRoutine {
            dataManagerService.deleteRoutine(byID: routine.id)
        }
    }
    
    func updateRoutineData() {
        let routine = environmentContext.selectedRoutine
        let selectedCellIndex = environmentContext.selectedCellIndex
        
        self.days = Routine.decodeDays(
            routine?.daysJSON ?? ""
        )
        self.start = routine?.start ?? "8:00 AM"
        self.habits = routine?.habits ?? []
        self.borderColor = Color.from(
            description: routine?.color ?? "white"
        )
        
        routineTitle = getRoutineTitle(index: selectedCellIndex)
        backgroundImage = getRoutineBackgroundImage(index: selectedCellIndex)
    }
    
    var body: some View {
        VStack {
            RoutineHeaderView(
                title: $routineTitle
            )
            
            VStack(spacing: 0) {
                RoutineDetailView(
                    start: $start,
                    days: $days
                )
                
                Spacer()
                
                RoutineHabitView(
                    habits: $habits
                )
            }
            .overlay(
                Image(backgroundImage)
                    .resizable()
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .horizontal)
                    .frame(height: environmentContext.screenHeight*0.92)
            )
            .overlay(
                VStack {
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                    Spacer()
                }
                    .frame(height: environmentContext.screenHeight*0.92)
            )
            .frame(height: environmentContext.screenHeight*0.92)
            .padding(.bottom, 10)
            .preferredColorScheme(.dark)
        }
        .onAppear {
            updateRoutineData()
        }
        .onChange(of: environmentContext.selectedRoutine) { _, _ in
            updateRoutineData()
        }
        .frame(
            width: environmentContext.screenWidth,
            height: environmentContext.screenHeight
        )
        .environment(\.handleDeleteRoutine, handleDeleteRoutine)
    }
}

#Preview {
    RoutineView()
}
