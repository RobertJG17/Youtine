//
//  ContextViewModel.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftData
import SwiftUI
import Observation

enum ContentViewModelErrors: Error {
    case UninitializedError(message: String)
    case UnidentifiedRoutineError(message: String)
}

@Observable
final class ContentViewModel {  // MARK: Acts as invocation/error handling layer for Data Manager
    private var context: ModelContext
    private let dataManager: DataManager
    
    init(context: ModelContext) {
        self.context = context
        self.dataManager = DataManager(context: context)
    }

    /// Method used invoke data manager write.
    /// - Parameters: Defined in Youtine class
    func saveRoutine(
        id: UUID,
        index: Int,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit]
    ) {
        do {
            try dataManager.saveRoutine(
                id: id,
                index: index,
                start: start,
                days: days,
                borderColor: borderColor,
                habits: habits
            )
        } catch {
            print(error)
        }
    }

    /// Method used to invoke data manager delete.
    /// - Parameter id: ID of parameter to delete
    func deleteRoutine(byID id: UUID) {
        let fetchDescriptor = FetchDescriptor<Youtine>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            let fetchedRoutines = try context.fetch(fetchDescriptor)
            
            if let routine = fetchedRoutines.first {
                try dataManager.deleteRoutine(routine: routine)
            } else {
                throw ContentViewModelErrors.UnidentifiedRoutineError(
                    message: """
                        Entity: ContentViewModel \n
                        Line: 48\n
                        Function Invocation: deleteRoutine()\n
                        Output: ERROR - Routine ID not found
                    """
                )
            }
        } catch {
            print(error)
        }
    }

}

