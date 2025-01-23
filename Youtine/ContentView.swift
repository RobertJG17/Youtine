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

    @Query var savedRoutines: [Youtine]
    
    @State var localRoutines: [Youtine?] = []
    
    @State var contextViewModel: ContextViewModel? = nil
        
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
                    Line: 29\n
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
                    Line: 45\n
                    Function Invocation: deleteRoutineFromDisk()\n
                    Error: Context View Model not defined
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
                    routines: localRoutines
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
        .onChange(of: savedRoutines, { _, newRoutines in
            localRoutines = newRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - newRoutines.count
                )
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
