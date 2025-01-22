//
//  DataManager.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftData
import SwiftUI
import Observation

enum DataManagerErrors: Error {
    case InvalidContext(message: String)
    case UpdateError(message: String)
    case SaveError(message: String)
    case DeleteError(message: String)
}

@Observable
final class DataManager  {
    private var context: ModelContext?
    
    init(context: ModelContext?) {
        self.context = context
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter entry: Existing instance found with descriptor from context
    /// - Parameter routine: Youtine  instance
    /// - Parameter definedContext: Context used to perform Swift Data object management operations
    func update(entry: Youtine, routine: Youtine, definedContext: ModelContext) throws -> Void {
        // Update the existing routine's properties
        entry.index = routine.index
        entry.start = routine.start
        entry.daysJSON = routine.daysJSON
        entry.borderColor = routine.borderColor

        // Save changes
        if definedContext.hasChanges {
            do {
                try definedContext.save()
                print("Routine updated successfully!")
            } catch {
                throw DataManagerErrors.UpdateError(
                    message: """
                        Entity: DataManager \n
                        Line: 41\n
                        Function Invocation: update()\n
                        Error: \(error.localizedDescription)
                    """
                )
            }
        } else {
            print("No changes to save.")
        }
        
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter routine: Youtine  instance
    /// - Parameter definedContext: Context used to perform Swift Data object management operations
    func save(routine: Youtine, definedContext: ModelContext) throws {
        do {
            definedContext.insert(routine)
            if definedContext.hasChanges {
                try definedContext.save()
                print("Routine saved successfully!")
            }
        } catch {
            throw DataManagerErrors.SaveError(
                message: """
                    Entity: DataManager \n
                    Line: 66\n
                    Function Invocation: save()\n
                    Error: \(error.localizedDescription)
                """
            )
        }
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter routine: Youtine  instance
    func saveRoutine(routine: Youtine) throws {
        guard let context = context else {
            throw ContextErrors.UninitializedError(
                message: """
                    Entity: DataManager \n
                    Line: 84\n
                    Function Invocation: saveRoutine()\n
                    Error: Nil context
                """
            )
        }
        
        let fetchDescriptor = FetchDescriptor<Youtine>(
            predicate: #Predicate { $0.id == routine.id },
            sortBy: [SortDescriptor(\Youtine.id)]
        )
        
        do {
            let existingEntry: [Youtine] = try context.fetch(fetchDescriptor)
            let validEntry = existingEntry.first
            
            if let entry = validEntry {
                try update(
                    entry: entry,
                    routine: routine,
                    definedContext: context
                )
            } else {
                try save(routine: routine, definedContext: context)
            }
            
        } catch {
            throw error
        }
    }
    
    /// Method used to set routine at specified index to nil
    /// - Parameters:
    ///   - routine: Youtine instance
    func deleteRoutine(routine: Youtine) throws {
        guard let context = context else {
            throw ContextErrors.UninitializedError(
                message: """
                    Entity: DataManager \n
                    Line: 123\n
                    Function Invocation: deleteRoutine()\n
                    Error: Nil context
                """
            )
        }
        
        context.delete(routine)
    }
}
