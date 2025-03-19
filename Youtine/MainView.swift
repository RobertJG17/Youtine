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
    
    func refreshRoutines(with otherRoutines: [Routine]) -> [Routine?] {
        var temp = Array<Routine?>.init(repeating: nil, count: MAX_ROUTINES)
        
        otherRoutines.forEach { routine in
            let index = routine.index
            temp[index] = routine
        }
        
        return temp
    }
    
    var body: some View {
        NavigationView {
            Router(
                routines: $routines
            )
        }
        .onAppear {
            // MARK: Set local state to array with youtines and nil entries otherwise
            routines = refreshRoutines(with: savedRoutines)
            
            // MARK: Prompt user for permission to schedule local notifications
            NotificationsService.promptNotificationsGrant()
        }
        .onChange(of: savedRoutines) { _, newRoutines in
            routines = refreshRoutines(with: newRoutines)
        }
    }
}

#Preview {
    MainView()
}
