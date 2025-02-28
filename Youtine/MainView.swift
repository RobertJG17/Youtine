//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    // MARK: Routines - MORNING | AFTERNOON | EVENING
    private let MAX_ROUTINES = 3

    @Query(FetchDescriptor<Routine>(
        sortBy: [SortDescriptor(\Routine.index, order: .forward)]
    )) var savedRoutines: [Routine]
    
    @State var routines: [Routine?] = []
    
    // MARK: Used in Extensions, encapsulates logic for Swift Data operations
    @State var dataManagerService: DataManagerService?
        
    // MARK: Context for Swift Data operations
    @Environment(\.modelContext) var context
    
    var authService: FirebaseAuthService
    
    init(authService: FirebaseAuthService) {
        self.authService = authService
    }
    
    var body: some View {
        NavigationView {
            Router(
                authService: authService,
                routines: $routines
            )
        }
        .onAppear {
            // MARK: Set local state to array with youtines and nil entries otherwise
            routines = savedRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - savedRoutines.count
                )

            // MARK: Initialize Data Manager with Swift Data context
            dataManagerService = DataManagerService(context: context)
            
            // MARK: Prompt user for permission to schedule local notifications
            NotificationsService.promptNotificationsGrant()
        }
        .onChange(of: savedRoutines) { _, newRoutines in
            routines = newRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - newRoutines.count
                )
        }
        .environment(\.writeRoutineToDisk, writeRoutineToDisk)
        .environment(\.deleteRoutineFromDisk, deleteRoutineFromDisk)
    }
}

#Preview {
    MainView(authService: FirebaseAuthService())
}
