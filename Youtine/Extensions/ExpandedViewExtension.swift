//
//  ExpandedViewExtension.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import Foundation


extension ExpandedView {
    var backgroundImage: String {
        switch(selectedCellIndex) {
        case 0:
            return "morning"
        case 1:
            return "noon"
        case 2:
            return "night"
        default:
            return "morning"
        }
    }
}
