//
//  RoutineExtensions.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/15/25.
//

import Foundation

import SwiftUI

// Utility to map color names to Color instances
extension Color {
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
        case "black":
            return .black
        case "white":
            return .white
        case "gray":
            return .gray
        default:
            print("Color: ", description.uppercased(), " does not have case statement")
            return .orange // Handle cases for unknown colors
        }
    }
}
