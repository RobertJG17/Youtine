//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Routines - MORNING | AFTERNOON | EVENING
    private let MAX_ROUTINES = 3

    @Query(FetchDescriptor<Youtine>(
        sortBy: [SortDescriptor(\Youtine.index, order: .forward)]
    )) var savedRoutines: [Youtine]

    @State var contentViewModel: ContentViewModel? = nil
    
    @State var localRoutines: [Youtine?] = Array.init(
        repeating: nil,
        count: 3
    )
        
    // MARK: Context used to initialize view model
    @Environment(\.modelContext) var context
    
    // MARK: Define content view model operations in Content View and pass them via context
    // MARK: NOTE: Passing contentViewModel as an arg seems superfluous
    func writeRoutineToDisk(
        id: UUID,
        index: Int,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit]
    ) throws -> Void {
        guard let cvm = contentViewModel else { throw ContentViewModelErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 32\n
                    Function Invocation: writeRoutineToDisk()\n
                    Error: Content View Model not defined
                """
            )
        }
        
        cvm.saveRoutine(
            id: id,
            index: index,
            start: start,
            days: days,
            borderColor: borderColor,
            habits: habits
        )
    }
    
    func deleteRoutineFromDisk(
        routine: Youtine
    ) throws -> Void {
        guard let cvm = contentViewModel else { throw ContentViewModelErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 48\n
                    Function Invocation: deleteRoutineFromDisk()\n
                    Error: Content View Model not defined
                """
            )
        }
        
        cvm.deleteRoutine(byID: routine.id)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                Router(
                    width: width,
                    height: height,
                    routines: $localRoutines
                )
            }
        }
        .onAppear {
            // MARK: Set local state to array with youtines and nil entries otherwise
            localRoutines = savedRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - savedRoutines.count
                )

            contentViewModel = ContentViewModel(context: context)
        }
        .onChange(of: savedRoutines, { _, newRoutines in
            localRoutines = newRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - newRoutines.count
                )
        })
        .environment(\.writeRoutineToDisk, writeRoutineToDisk)
        .environment(\.deleteRoutineFromDisk, deleteRoutineFromDisk)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
