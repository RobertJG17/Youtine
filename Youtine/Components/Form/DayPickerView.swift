//
//  DayPickerView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct DayPickerView: View {
    var width: CGFloat
    @Binding var selectedDays: [Int: String]
    
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
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: isFilled(currKey: 0) ? "m.square.fill" : "m.square")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 24, alignment: .top)
                .onTapGesture {
                    let currKey = 0
                    let day = "M"
                    handleDayClicked(currKey: currKey, day: day)
                }
            Image(systemName: isFilled(currKey: 1) ? "t.square.fill" : "t.square")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 24, alignment: .top)
                .onTapGesture {
                    let currKey = 1
                    let day = "T"
                    handleDayClicked(currKey: currKey, day: day)
                }
            Image(systemName: isFilled(currKey: 2) ? "w.square.fill" : "w.square")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 24, alignment: .top)
                .onTapGesture {
                    let currKey = 2
                    let day = "W"
                    handleDayClicked(currKey: currKey, day: day)
                }
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: isFilled(currKey: 3) ? "t.square.fill" : "t.square")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, -3)
                Image(systemName: isFilled(currKey: 3) ? "h.square.fill" : "h.square")
                    .resizable()
                    .scaledToFit()
                    
            }
            .frame(width: 48, height: 24.5, alignment: .top)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .background(Color.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                let currKey = 3
                let day = "Th"
                handleDayClicked(currKey: currKey, day: day)
            }
            
            Image(systemName: isFilled(currKey: 4) ? "f.square.fill" : "f.square")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 24, alignment: .top)
                .onTapGesture {
                    let currKey = 4
                    let day = "F"
                    handleDayClicked(currKey: currKey, day: day)
                }
            Image(systemName: isFilled(currKey: 5) ? "s.square.fill" : "s.square")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 24, alignment: .top)
                .onTapGesture {
                    let currKey = 5
                    let day = "S"
                    handleDayClicked(currKey: currKey, day: day)
                }
            HStack(spacing: 0) {
                Image(systemName: isFilled(currKey: 6) ? "s.square.fill" : "s.square")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, -3)
                Image(systemName: isFilled(currKey: 6) ? "u.square.fill" : "u.square")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 48, height: 24.5, alignment: .top)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .background(Color.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                let currKey = 6
                let day = "Su"
                handleDayClicked(currKey: currKey, day: day)
            }
        }
        .frame(width: width / 1.5)
        .transition(.asymmetric(insertion: .scale, removal: .opacity))
        .symbolEffect(.bounce, value: selectedDays)
        .frame(width: width*0.78)
        .padding(.leading, 6)
        .onChange(of: selectedDays) { prevDays, newDays in
            print("Old days: ", prevDays)
            print("New days: ", newDays)
        }
    }
}

#Preview {
    DayPickerView(
        width: 402.0,
        selectedDays: .constant(
            [
                0: "M",
                1: "T"
            ]
        )
    )
}
