//
//  Helpers.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/17/25.
//

import SwiftUI

func getRoutineColor(index: Int?) -> Color {
    var colorToReturn: Color = Color.white
    guard let currIdx = index else { return colorToReturn }
    
    switch(currIdx) {
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

func getRoutineScoreColor(habits: [Habit], habitsCompleted: Int) -> Color {
    guard habits.count != 0 else { return Color.white }
    
    var color = Color.white
    let score = Double(habitsCompleted)/Double(habits.count)
            
    if score >= 0.0 && score < 0.33333 {
        color = Color.red
    } else if score >= 0.33333 && score < 0.66666 {
        color = Color.orange
    } else if score >= 0.66666 && score < 0.8 {
        color = Color.yellow
    } else if score >= 0.8 {
        color = Color.green
    }
    
    return color
}

func getRoutineTitle(index: Int?) -> String {
    var titleToReturn: String = "Routine"
    guard let currIdx = index else { return titleToReturn }
    
    switch(currIdx) {
    case 0:
        titleToReturn = "Morning Routine ☀️"
    case 1:
        titleToReturn = "Afternoon Routine"
    case 2:
        titleToReturn = "Evening Routine 🌙"
    default:
        titleToReturn = "Routine"
    }
    
    return titleToReturn
}

func getRoutineBackgroundImage(index: Int?) -> String {
    var backgroundImage: String = "morning"
    guard let currIdx = index else { return backgroundImage }
    
    switch(currIdx) {
    case 0:
        backgroundImage = "morning"
    case 1:
        backgroundImage = "noon"
    case 2:
        backgroundImage = "night"
    default:
        backgroundImage = "morning"
    }
    
    return backgroundImage
}

func getRoutineStartTime(index: Int?) -> String {
    var timeToReturn: String = "8:00 AM"
    guard let currIdx = index else { return timeToReturn }
    
    switch(currIdx) {
    case 0:
        timeToReturn = "8:00 AM"
    case 1:
        timeToReturn = "12:00 PM"
    case 2:
        timeToReturn = "8:00 PM"
    default:
        timeToReturn = "8:00 AM"
    }
    
    return timeToReturn
}

func getDateFromString(timeString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures correct AM/PM parsing
    let date = formatter.date(from: timeString)
    
    return date!
}
    
func getDateComponents(date: Date) -> DateComponents {
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
    return dateComponents
}
