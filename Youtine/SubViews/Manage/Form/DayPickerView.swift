//
//  DayPickerView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

import SwiftUI

struct DayPickerView: View {
    var routineColor: Color
    @Binding var selectedDays: [Int: String]
    
    @Environment(UIStore.self) var uiStore
    
    private let days = [
        (2, "M"), (3, "T"), (4, "W"), (5, "Th"),
        (6, "F"), (7, "Sa"), (1, "S")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.0) { (currKey, day) in
                getDayButton(currKey: currKey, day: day)
            }
        }
        .frame(width: uiStore.screenWidth * 0.78)
        .foregroundStyle(routineColor)
        .animation(.easeIn, value: selectedDays)
        .padding(.leading, 6)
    }
    
    @ViewBuilder
    private func getDayButton(currKey: Int, day: String) -> some View {
        if day == "Th" || day == "Sa" {
            HStack(spacing: 0) {
                let firstChar = day == "Th" ? "t" : "s"
                let secondChar = day == "Th" ? "h" : "a"
                
                Image(systemName: isFilled(currKey: currKey) ? "\(firstChar).square.fill" : "\(firstChar).square")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, -3)
                Image(systemName: isFilled(currKey: currKey) ? "\(secondChar).square.fill" : "\(secondChar).square")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 48, height: 24.5)
            .padding(.horizontal, 10)
            .background(Color.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                handleDayClicked(currKey: currKey, day: day)
            }
        } else {
            Image(systemName: isFilled(currKey: currKey) ? "\(day.lowercased()).square.fill" : "\(day.lowercased()).square")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 24)
                .onTapGesture {
                    handleDayClicked(currKey: currKey, day: day)
                }
        }
    }
}


#Preview {
    DayPickerView(
        routineColor: Color.yellow,
        selectedDays: .constant(
            [
                0: "M",
                1: "T"
            ]
        )
    )
}
