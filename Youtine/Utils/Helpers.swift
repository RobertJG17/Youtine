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

func getRoutineTitle(index: Int?) -> String {
    var titleToReturn: String = "Routine"
    guard let currIdx = index else { return titleToReturn }
    
    switch(currIdx) {
    case 0:
        titleToReturn = "Morning Routine"
    case 1:
        titleToReturn = "Afternoon Routine"
    case 2:
        titleToReturn = "Evening Routine"
    default:
        titleToReturn = "Routine"
    }
    
    return titleToReturn
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
    
