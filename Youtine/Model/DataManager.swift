//
//  DataManager.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftData
import SwiftUICore

enum DataManagerErrors: Error {
    case InvalidContext(message: String)
    case SaveError(message: String)
    case DeleteError(message: String)
}

@Observable
final class DataManager  {
    private var context: ModelContext?
    
    init(context: ModelContext?) {
        self.context = context
    }
    
    /// Method used to save routines upon form submission
    /// - Parameter routines: [Youtine?] Should be an array with up to 3 nil values or 3 Youtine instances
    func saveRoutines(routines: [Youtine?]) throws {
        guard let context = context else { return }
        for routine in routines {
            if let newRoutine = routine {
                context.insert(newRoutine)
            }
        }
        
        do {
            if context.hasChanges {
                try context.save() // Save changes to persist all objects
            }
        } catch {
            throw DataManagerErrors.SaveError(
                message: "Error saving routines: \(error.localizedDescription)"
            )
        }
    }

    
    /// Method used to set routine at specified index to nil
    /// - Parameters:
    ///   - routines: [Youtine?] Should be an array with at least 1 non nil entry
    ///   - index: The selected index used to delete the desired routine
    func deleteRoutine(routines: [Youtine?], index: Int) throws {
        do {
            guard let context = context else { return }
            let routine = routines[index]
            
            if let routineToDelete = routine {
                context.delete(routineToDelete)
            } else {
                throw DataManagerErrors.DeleteError(message: "Invalid index to delete \nRoutines: \(routines)\nIndex: \(index)")
            }
            
        } catch {
            throw DataManagerErrors.DeleteError(
                message: "Error deleting routine: \(error)"
            )
        }
    }
}
