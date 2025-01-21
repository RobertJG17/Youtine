//
//  ContextViewModel.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftData
import SwiftUI

@Observable
final class ContextViewModel {  // MARK: Acts as invocation/error handling layer for Data Manager
    private var context: ModelContext
    private let dataManager: DataManager
    
    init(context: ModelContext) {
        self.context = context
        self.dataManager = DataManager(context: context)
    }

    /// Method used invoke data manager write
    /// - Parameter routines: [Youtine?] Should be an array with up to 3 nil values or 3 Youtine instances
    func saveRoutines(routines: [Youtine?]) {
        do {
            try dataManager.saveRoutines(
                routines: routines
            )
        } catch {
            print("Error encountered in view model saveRoutine: ", error)
        }
    }

    /// Method used to invoke data manager delete.
    /// - Parameters:
    ///   - routines: [Youtine?] Should be an array with at least 1 non nil entry
    ///   - index: The selected index used to delete the desired routine
    func deleteRoutine(routines: [Youtine], index: Int) {
        do {
            try dataManager.deleteRoutine(
                routines: routines,
                index: index
            )
        } catch {
            print("Error encountered in view model deleteRoutine: ", error)
        }
        
    }
}

