//
//  CreateRoutineViewExtension.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

extension FormView {
    var routineTitle: String {
        switch(index) {
        case 0:
            return "Morning Routine"
        case 1:
            return "Afternoon Routine"
        case 2:
            return "Evening Routine"
        default:
            return "Invalid Routine index: \(index)"
        }
    }
    
    var routineColor: Color {
        switch(index) {
        case 0:
            return Color.yellow
        case 1:
            return Color.blue
        case 2:
            return Color.red
        default:
            return Color.white
        }
    }
}
