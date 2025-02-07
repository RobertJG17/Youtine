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
    
    // MARK: Used in Extensions
    @State var dataManagerService: DataManager?
        
    // MARK: Context used to initialize service model
    @Environment(\.modelContext) var context
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
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
        })
        .environment(\.writeRoutineToDisk, writeRoutineToDisk)
        .environment(\.deleteRoutineFromDisk, deleteRoutineFromDisk)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
