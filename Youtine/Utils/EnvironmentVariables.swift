//
//  EnvironmentVariables.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

enum Page {
    case home
    case createRoutine
    case routine
}


// MARK: Environment keys
struct CurrentPageKey: EnvironmentKey {
    static let defaultValue: Binding<Page> = .constant(.home)
}


extension EnvironmentValues {
    var currentPage: Binding<Page> {
        get { self[CurrentPageKey.self] }
        set { self[CurrentPageKey.self] = newValue }
    }
}
