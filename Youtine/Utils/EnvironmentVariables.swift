//
//  EnvironmentVariables.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

// TODO: Abstract environment setup to observable class
// MARK: Environment keys
struct CurrentPageKey: EnvironmentKey {
    static let defaultValue: Binding<Page> = .constant(.home)
}

struct ScreenWidthKey: EnvironmentKey {
    static let defaultValue: Binding<CGFloat> = .constant(400)
}

struct ScreenHeightKey: EnvironmentKey {
    static let defaultValue: Binding<CGFloat> = .constant(600)
}

struct WriteRoutineToDiskKey: EnvironmentKey {
    static let defaultValue: (
        UUID,
        Int,
        String,
        [Int: String],
        Color,
        [Habit]
    ) throws -> Void = {
        _, _, _, _, _, _
        in
    }
}

struct DeleteRoutineFromDiskKey: EnvironmentKey {
    static let defaultValue: (Routine) throws -> Void = { _ in }
}

struct HandleFormSubmitKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

struct HandleDeleteRoutineKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var currentPage: Binding<Page> {
        get { self[CurrentPageKey.self] }
        set { self[CurrentPageKey.self] = newValue }
    }
    
    var screenWidth: Binding<CGFloat> {
        get { self[ScreenWidthKey.self] }
        set { self[ScreenWidthKey.self] = newValue }
    }
    
    var screenHeight: Binding<CGFloat> {
        get { self[ScreenHeightKey.self] }
        set { self[ScreenHeightKey.self] = newValue }
    }
    
    var writeRoutineToDisk: (
        _ id: UUID,
        _ index: Int,
        _ start: String,
        _ days: [Int: String],
        _ borderColor: Color,
        _ habits: [Habit]
    ) throws -> Void {
        get { self[WriteRoutineToDiskKey.self] }
        set { self[WriteRoutineToDiskKey.self] = newValue }
    }
    
    var deleteRoutineFromDisk: (
        _ routine: Routine
    ) throws -> Void {
        get { self[DeleteRoutineFromDiskKey.self] }
        set { self[DeleteRoutineFromDiskKey.self] = newValue }
    }
    
    var handleFormSubmit: () -> Void  {
        get { self[HandleFormSubmitKey.self] }
        set { self[HandleFormSubmitKey.self] = newValue }
    }
    
    var handleDeleteRoutine: () -> Void {
        get { self[HandleDeleteRoutineKey.self] }
        set { self[HandleDeleteRoutineKey.self] = newValue }
    }
}
