//
//  CGColorExtensions.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

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
