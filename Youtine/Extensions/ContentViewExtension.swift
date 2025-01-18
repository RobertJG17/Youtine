//
//  ContentViewExtensions.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/15/25.
//

import Foundation


extension ContentView {
    static var itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
