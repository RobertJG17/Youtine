//
//  ContextViewModel.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftData
import SwiftUI
import Observation

enum ContextErrors: Error {
    case UninitializedError(message: String)
}

@Observable
final class ContextViewModel {  // MARK: Acts as invocation/error handling layer for Data Manager
    private var context: ModelContext
    private let dataManager: DataManager
    
    init(context: ModelContext) {
        self.context = context
        self.dataManager = DataManager(context: context)
    }

    /// Method used invoke data manager write
    /// - Parameter routines: Youtine instance
    func saveRoutine(routine: Youtine) {
        do {
            try dataManager.saveRoutine(
                routine: routine
            )
        } catch {
            print(error)
        }
    }

    /// Method used to invoke data manager delete.
    /// - Parameters:
    /// - Parameter routines: Youtine instance
    func deleteRoutine(byID id: UUID) {
        let fetchDescriptor = FetchDescriptor<Youtine>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            let fetchedRoutines = try context.fetch(fetchDescriptor)
            
            if let routine = fetchedRoutines.first {
                try dataManager.deleteRoutine(routine: routine)
            } else {
                print("No routine found with the given ID.")
            }
        } catch {
            print(error)
        }
    }

}

