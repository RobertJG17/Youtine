//
//  DayPickerViewExtension.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import Foundation

extension DayPickerView {
    func isIndDictionary(currKey: Int) -> Dictionary<Int,String>.Element? {
        return selectedDays.first(
            where: {
                (key: Int, value: String) in
            currKey == key
        })
    }
    
    func handleDayClicked(currKey: Int, day: String) {
        let inDictionary = isIndDictionary(currKey: currKey)
        
        if inDictionary != nil {
            selectedDays.removeValue(forKey: currKey)
        } else {
            selectedDays[currKey] = day
        }
    }
    
    func isFilled(currKey: Int) -> Bool {
        let inDictionary = isIndDictionary(currKey: currKey)
        
        if inDictionary != nil {
            return true
        } else {
            return false
        }
    }
}
