//
//  EnvironmentVariables.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

// MARK: Environment keys
struct CurrentPageKey: EnvironmentKey {
    static let defaultValue: Binding<Page> = .constant(.home)
}

struct ContextViewModelKey: EnvironmentKey {
    static let defaultValue: ContextViewModel? = nil
}

struct WriteRoutineToDiskKey: EnvironmentKey {
    static let defaultValue: (Youtine, ContextViewModel?) throws -> Void = { _, _  in }
}

struct DeleteRoutineFromDiskKey: EnvironmentKey {
    static let defaultValue: (Youtine, ContextViewModel?) throws -> Void = { _, _  in }
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
    
    var contextViewModel: ContextViewModel? {
        get { self[ContextViewModelKey.self] }
        set { self[ContextViewModelKey.self] = newValue }
    }
    
    var writeRoutineToDisk: (
        _ routine: Youtine,
        _ contextViewModel: ContextViewModel?
    ) throws -> Void {
        get { self[WriteRoutineToDiskKey.self] }
        set { self[WriteRoutineToDiskKey.self] = newValue }
    }
    
    var deleteRoutineFromDisk: (
        _ routine: Youtine,
        _ contextViewModel: ContextViewModel?
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
