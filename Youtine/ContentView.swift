//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    static private let MAX_ROUTINE_COUNT = 3

    @Query var savedRoutines: [Youtine]
    
    @State var localRoutines: [Youtine?] = Array(repeating: nil, count: MAX_ROUTINE_COUNT)
    
    @State var contextViewModel: ContextViewModel? = nil
    
    // MARK: Routines - MORNING | AFTERNOON | EVENING
    let MAX_ROUTINES: Int = 3
    
    // MARK: Context used to initialize view model
    @Environment(\.modelContext) var context
    
    
    // MARK: Define context view model operations in Content View and pass them via context
    func writeRoutineToDisk(
        routine: Youtine,
        contextViewModel: ContextViewModel?
    ) throws -> Void {
        guard let cvm = contextViewModel else { throw ContextErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 32\n
                    Function Invocation: writeRoutineToDisk()\n
                    Error: Context View Model not defined
                """
            )
        }
        cvm.saveRoutine(routine: routine)
    }
    
    func deleteRoutineFromDisk(
        routine: Youtine,
        contextViewModel: ContextViewModel?
    ) throws -> Void {
        guard let cvm = contextViewModel else { throw ContextErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 48\n
                    Function Invocation: deleteRoutineFromDisk()\n
                    Error: Context View Model not defined
                """
            )
        }
        cvm.deleteRoutine(routine: routine)
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
            
            contextViewModel = ContextViewModel(context: context)
        }
        .onChange(of: savedRoutines, { oldValue, newValue in
            print("OLD ROUTINES: ", oldValue)
            print("NEW ROUTINES: ", newValue)
        })
        .environment(\.writeRoutineToDisk, writeRoutineToDisk)
        .environment(\.deleteRoutineFromDisk, deleteRoutineFromDisk)
        .environment(\.contextViewModel, contextViewModel)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
