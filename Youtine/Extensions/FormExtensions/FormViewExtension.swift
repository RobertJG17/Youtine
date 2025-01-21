//
//  FormViewExtension.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

extension FormView {
    func getRoutineColor(index: Int) -> Color {
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
    
    func getRoutineTitle(index: Int?) -> String {
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
