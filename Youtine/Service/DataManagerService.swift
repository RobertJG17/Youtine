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
final class DataManagerService {
    private var context: ModelContext?
    private var notificationsManager: NotificationsService
    
    init(context: ModelContext?) {
        self.context = context
        self.notificationsManager = NotificationsService()
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter entry: Existing instance found with descriptor from context
    /// - Parameter definedContext: Context used to perform Swift Data object management operations
    /// - Parameters {...rest}: Youtine properties used to update existing entry
    func update(
        entry: Routine,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit],
        definedContext: ModelContext
    ) throws -> Void {
        // !!!: MAKE SURE TO MAP THRU ALL NECESSARY PROPERTIES
        entry.start = start
        entry.daysJSON = Routine.encodeDays(days)
        entry.borderColor = borderColor.description
        entry.habits = habits

        // Save changes
        if definedContext.hasChanges {
            do {
                try definedContext.save()
                
                // MARK: Update existing local notification for application
                notificationsManager.updateNotification(
                    id: entry.id.uuidString,
                    index: entry.index,
                    newStartTime: start
                )
                
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
    /// - Parameter routine: Routine  instance
    /// - Parameter definedContext: Context used to perform Swift Data object management operations
    func save(routine: Routine, definedContext: ModelContext) throws {
        do {
            definedContext.insert(routine)
            if definedContext.hasChanges {
                try definedContext.save()
                
                // MARK: Create new local notification for application
                notificationsManager.addNotification(
                    id: routine.id.uuidString,
                    index: routine.index,
                    startTime: routine.start
                )
                
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
    /// - Parameter id: ID of Routine
    /// - Parameter index: Index of Routine
    /// - Parameter start: Start time of Routine
    /// - Parameter days: Days that a user would like to have this Routine
    /// - Parameter borderColor: Color that a user has chosen for their  routine
    /// - Parameter habits: Habits that a user has configured for their Routine
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
            // MARK: Check if existing Routine object w/ id exists
            let fetchDescriptor = FetchDescriptor<Routine>(
                predicate: #Predicate { currRoutine in
                    currRoutine.id == id // ???: Predicate won't bark now
                },
                sortBy: [SortDescriptor(\Routine.id)]
            )
            
            let existingEntry: [Routine] = try context.fetch(fetchDescriptor)
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
                let routine = Routine(
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
    ///   - id: ID of Routine we want to delete
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
            
            let fetchDescriptor = FetchDescriptor<Routine>( predicate: #Predicate { $0.id == id } )
            let fetchedRoutines = try context.fetch(fetchDescriptor)
            
            if let routine = fetchedRoutines.first {
                context.delete(routine)
                
                // MARK: Remove local notification for application
                notificationsManager.deleteNotification(id: routine.id.uuidString)
                
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
    }
}
