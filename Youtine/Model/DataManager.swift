//
//  DataManager.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftData
import SwiftUI
import Observation

// This will become sole file over content view model
// Since we will just inject this service file into content view
// and call the save/update and delete methods instead of having a pass thru structure

enum DataManagerErrors: Error {
    case InvalidContext(message: String)
    case UpdateError(message: String)
    case SaveError(message: String)
    case DeleteError(message: String)
    case UnidentifiedRoutineError(message: String)
    case UninitializedError(message: String)
}

@Observable
final class DataManager {
    private var context: ModelContext?
    
    init(context: ModelContext?) {
        self.context = context
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter entry: Existing instance found with descriptor from context
    /// - Parameter definedContext: Context used to perform Swift Data object management operations
    /// - Parameters {...rest}: Youtine properties used to update existing entry
    func update(
        entry: Youtine,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit],
        definedContext: ModelContext
    ) throws -> Void {
        // !!!: MAKE SURE TO MAP THRU ALL NECESSARY PROPERTIES
        entry.start = start
        entry.daysJSON = Youtine.encodeDays(days)
        entry.borderColor = borderColor.description
        entry.habits = habits

        // Save changes
        if definedContext.hasChanges {
            do {
                try definedContext.save()
                print("""
                    Entity: DataManager \n
                    Line: 48\n
                    Function Invocation: update()\n
                    Output: ROUTINE UPDATED SUCCESSFULLY!
                """)
            } catch {
                throw DataManagerErrors.UpdateError(
                    message: """
                        Entity: DataManager \n
                        Line: 48\n
                        Function Invocation: update()\n
                        Output: \(error.localizedDescription)
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
                print("""
                    Entity: DataManager \n
                    Line: 77\n
                    Function Invocation: save()\n
                    Output: ROUTINE SAVED SUCCESSFULLY!
                """)
            }
        } catch {
            throw DataManagerErrors.SaveError(
                message: """
                    Entity: DataManager \n
                    Line: 77\n
                    Function Invocation: save()\n
                    Output: \(error.localizedDescription)
                """
            )
        }
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter routine: Youtine  instance
    func saveRoutine(
        id: UUID,
        index: Int,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit]
    ) {
        do {
            guard let context = context else {
                throw DataManagerErrors.InvalidContext(
                    message: """
                        Entity: DataManager
                        Line: 107
                        Function Invocation: saveRoutine()
                        Error: Nil contenxt
                    """
                )
            }
            
            // ???: id referenced outside of predicate declaration scope
            // MARK: Check if existing Youtine object w/ id exists
            let fetchDescriptor = FetchDescriptor<Youtine>(
                predicate: #Predicate { currRoutine in
                    currRoutine.id == id // ???: Predicate won't bark now
                },
                sortBy: [SortDescriptor(\Youtine.id)]
            )
            
            let existingEntry: [Youtine] = try context.fetch(fetchDescriptor)
            let validEntry = existingEntry.first
            
            
            if let entry = validEntry {
                try update(
                    entry: entry,
                    start: start,
                    days: days,
                    borderColor: borderColor,
                    habits: habits,
                    definedContext: context
                )
            } else {
                let routine = Youtine(
                    index: index,
                    start: start,
                    days: days,
                    borderColor: borderColor,
                    habits: habits
                )
                
                try save(
                    routine: routine,
                    definedContext: context
                )
            }
        } catch {
            print(error)
        }
    }
    
    /// Method used to set routine at specified index to nil
    /// - Parameters:
    ///   - routine: Youtine instance
    func deleteRoutine(byID id: UUID) {
        do {
            guard let context = context else {
                throw DataManagerErrors.InvalidContext(
                    message: """
                        Entity: DataManager
                        Line: 170
                        Function Invocation: deleteRoutine()
                        Error: Nil contenxt
                    """
                )
            }
            
            let fetchDescriptor = FetchDescriptor<Youtine>( predicate: #Predicate { $0.id == id } )
            let fetchedRoutines = try context.fetch(fetchDescriptor)
            
            if let routine = fetchedRoutines.first {
                context.delete(routine)
                print("""
                      Entity: DataManager
                      Line: 185
                      Function Invocation: deleteRoutine()
                      Output: SUCCESS, ROUTINE DELETED!
                  """)
            } else {
                throw DataManagerErrors.UnidentifiedRoutineError(
                    message: """
                        Entity: Data Manager \n
                        Line: 185\n
                        Function Invocation: deleteRoutine()\n
                        Output: ERROR - Routine ID not found
                    """
                )
            }
        } catch {
            print(error)
        }
    
//        do {
//            try context.save()
//            print("""
//                Entity: DataManager \n
//                Line: 141\n
//                Function Invocation: deleteRoutine()\n
//                Output: Success, context successfully deleted.
//            """)
//        } catch {
//            throw DataManagerErrors.SaveError(
//                message: """
//                    Entity: DataManager \n
//                    Line: 141\n
//                    Function Invocation: deleteRoutine()\n
//                    Error: \(error.localizedDescription)
//                """
//            )
//        }
    }
}
