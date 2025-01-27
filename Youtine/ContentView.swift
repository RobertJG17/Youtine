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
    
    @State var localRoutines: [Youtine?] = Array.init(
        repeating: nil,
        count: 3
    )
    
    @State var dataManagerService: DataManager?
        
    // MARK: Context used to initialize view model
    @Environment(\.modelContext) var context
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    // MARK: Define Data Manager Service (DMS) operations in Content View and pass them via context
    func writeRoutineToDisk(
        id: UUID,
        index: Int,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit]
    ) throws -> Void {
        guard let dms = dataManagerService else { throw DataManagerErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 42\n
                    Function Invocation: writeRoutineToDisk()\n
                    Error: Content View Model not defined
                """
            )
        }
        
        dms.saveRoutine(
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
        guard let dms = dataManagerService else { throw DataManagerErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 48\n
                    Function Invocation: deleteRoutineFromDisk()\n
                    Error: Content View Model not defined
                """
            )
        }
        
        dms.deleteRoutine(byID: routine.id)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                Router(
                    routines: $localRoutines
                )
                .onAppear {
                    // MARK: Set screenWidth and screenHeight
                    screenWidth.wrappedValue = width
                    screenHeight.wrappedValue = height
                }
            }
        }
        .onAppear {
            // MARK: Set local state to array with youtines and nil entries otherwise
            localRoutines = savedRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - savedRoutines.count
                )

            dataManagerService = DataManager(context: context)
        }
        .onChange(of: savedRoutines, { _, newRoutines in
            localRoutines = newRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - newRoutines.count
                )
            
            print("""
               \n\n\tEntity: ContentView
               \tLine: 105
               \tInvocation: onChange(savedRoutines)
               \tOutput: \n\n\tNew routines: \n\n\(displayRoutines(routines: newRoutines))
            """)
        })
        .environment(\.writeRoutineToDisk, writeRoutineToDisk)
        .environment(\.deleteRoutineFromDisk, deleteRoutineFromDisk)
        .preferredColorScheme(.dark)
    }
    
    // MARK: Debug helper function
    func displayRoutines(routines: [Youtine?]) -> String {
        var outputStr = ""
        
        routines.forEach { routine in
            if let validRoutine = routine {
                outputStr += "\tID: \(validRoutine.id)\n"
                outputStr += "\tIndex: \(validRoutine.index)\n"
                outputStr += "\tStart: \(validRoutine.start)\n"
                outputStr += "\tColor: \(validRoutine.borderColor)\n"
                outputStr += "\n"
            }
        }
        
        return outputStr
    }
}

#Preview {
    ContentView()
}
