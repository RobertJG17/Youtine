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
final class DataManager {
    private var context: ModelContext?
    
    init(context: ModelContext?) {
        self.context = context
    }
    
    /// Method used to save routine upon form submission
    /// - Parameter entry: Existing instance found with descriptor from context
    /// - Parameter routine: Youtine  instance
    /// - Parameter definedContext: Context used to perform Swift Data object management operations
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
                    Line: 65\n
                    Function Invocation: save()\n
                    Error: \(error.localizedDescription)
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
    ) throws {
        guard let context = context else {
            throw DataManagerErrors.InvalidContext(
                message: """
                    Entity: DataManager \n
                    Line: 84\n
                    Function Invocation: saveRoutine()\n
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
        
        do {
            let existingEntry: [Youtine] = try context.fetch(fetchDescriptor)
            let validEntry = existingEntry.first
            
            print("Routine exists: ", existingEntry)
            
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
            throw error
        }
    }
    
    /// Method used to set routine at specified index to nil
    /// - Parameters:
    ///   - routine: Youtine instance
    func deleteRoutine(routine: Youtine) throws {
        guard let context = context else {
            throw DataManagerErrors.InvalidContext(
                message: """
                    Entity: DataManager \n
                    Line: 134\n
                    Function Invocation: saveRoutine()\n
                    Error: Nil contenxt
                """
            )
        }

        context.delete(routine)
        
        print("""
              Entity: DataManager \n
              Line: 141\n
              Function Invocation: deleteRoutine()\n
              Output: Success, context successfully deleted.
          """)
        
//        do {
//            try context.save()
//            print("""
//                Entity: DataManager \n
//                Line: 141\n
//                Function Invocation: deleteRoutine()\n
//                Output: Success, context successfully deleted.
//            """)
//        } catch {
//            // MARK: Calling save error since error was thrown on .save()
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
