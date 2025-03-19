//
//  EnvironmentVariables.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct HandleFormSubmitKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

struct HandleDeleteRoutineKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var handleFormSubmit: () -> Void  {
        get { self[HandleFormSubmitKey.self] }
        set { self[HandleFormSubmitKey.self] = newValue }
    }
    
    var handleDeleteRoutine: () -> Void {
        get { self[HandleDeleteRoutineKey.self] }
        set { self[HandleDeleteRoutineKey.self] = newValue }
    }
}
