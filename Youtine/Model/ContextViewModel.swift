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
    func deleteRoutine(routine: Youtine) {
        do {
            try dataManager.deleteRoutine(
                routine: routine
            )
        } catch {
            print(error)
        }
        
    }
}

