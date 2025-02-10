//
//  Extensions.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/21/25.
//

import SwiftUI

// MARK: CORE (START)
extension Color {
    static let validColors: [Color] = [
        .red,
        .blue,
        .green,
        .yellow,
        .orange,
        .pink,
        .purple,
        .white,
    ]
    
    static func from(description: String) -> Color {
        switch description.lowercased() {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "pink":
            return .pink
        case "purple":
            return .purple
        case "white":
            return .white
        default:
            print("Color: ", description.uppercased(), " does not have case statement")
            return .orange // Handle cases for unknown colors
        }
    }
}
// MARK: CORE (END)

// !!!: -----------------------------------------

// MARK: VIEWS (START)
extension ContentView {
    static var itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    func promptNotificationsGrant() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications prompt finished!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Define Data Manager Service (DMS) operations in Content View and pass them via context
    func writeRoutineToDisk(
        id: UUID,
        index: Int,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit]
    ) throws -> Void {
        guard let dms = dataManagerService else { throw DataManagerErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 40\n
                    Function Invocation: writeRoutineToDisk()\n
                    Error: Data Manager not defined
                """
            )
        }
        
        dms.saveRoutine(
            id: id,
            index: index,
            start: start,
            days: days,
            borderColor: borderColor,
            habits: habits
        )
    }
    
    func deleteRoutineFromDisk(
        routine: Routine
    ) throws -> Void {
        guard let dms = dataManagerService else { throw DataManagerErrors.UninitializedError(
                message: """
                    Entity: ContentView \n
                    Line: 63\n
                    Function Invocation: deleteRoutineFromDisk()\n
                    Error: Data Manager not defined
                """
            )
        }
        
        dms.deleteRoutine(byID: routine.id)
    }
}

extension ManageRoutineView {
    static func getRoutineColor(index: Int) -> Color {
        var colorToReturn: Color = Color.white
        switch(index) {
        case 0:
            colorToReturn = Color.yellow
        case 1:
            colorToReturn = Color.blue
        case 2:
            colorToReturn = Color.red
        default:
            colorToReturn = Color.white
        }
        
        return colorToReturn
    }

    static func getRoutineTitle(index: Int?) -> String {
        guard let currIdx = index else { return "Routine" }
        
        var title: String
        switch(currIdx) {
        case 0:
            title = "Morning Routine"
        case 1:
            title = "Afternoon Routine"
        case 2:
            title = "Evening Routine"
        default:
            title = "Routine"
        }
        
        return title
    }
}

extension RoutineView {
    var backgroundImage: String {
        switch(selectedCellIndex) {
        case 0:
            return "morning"
        case 1:
            return "noon"
        case 2:
            return "night"
        default:
            return "morning"
        }
    }
}

extension DayPickerView {
    func isIndDictionary(currKey: Int) -> Dictionary<Int,String>.Element? {
        return selectedDays.first(
            where: {
                (key: Int, value: String) in
                currKey == key
            })
    }
    
    func handleDayClicked(currKey: Int, day: String) {
        let inDictionary = isIndDictionary(currKey: currKey)
        
        if inDictionary != nil {
            selectedDays.removeValue(forKey: currKey)
        } else {
            selectedDays[currKey] = day
        }
    }
    
    func isFilled(currKey: Int) -> Bool {
        let inDictionary = isIndDictionary(currKey: currKey)
        
        if inDictionary != nil {
            return true
        } else {
            return false
        }
    }
}

// MARK: VIEWS (END)

// !!!: -----------------------------------------
