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
