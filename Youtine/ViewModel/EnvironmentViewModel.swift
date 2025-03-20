//
//  EnvironmentViewModel.swift
//  Youtine
//
//  Created by Bobby Guerra on 3/17/25.
//

import SwiftUI
import Observation
import SwiftData

@Observable
class RoutineEnvironment {
    var currentPage: Page = .home
    var selectedCellIndex: Int? = nil
    var selectedRoutine: Routine? = nil
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    func updatePage(to newPage: Page) {
        self.currentPage = newPage
    }
    
    func updateSelectedCellIndex(to newSelectedCellIndex: Int?) {
        self.selectedCellIndex = newSelectedCellIndex
    }
    
    func updateSelectedRoutine(to newSelectedRoutine: Routine?) {
        self.selectedRoutine = newSelectedRoutine
    }
    
    func updateWidth(to newWidth: CGFloat) {
        self.screenWidth = newWidth
    }
    
    func updateHeight(to newHeight: CGFloat) {
        self.screenHeight = newHeight
    }
}
