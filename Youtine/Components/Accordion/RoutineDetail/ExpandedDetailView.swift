//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedDetailView: View {
    var start: String
    @Binding var routine: Youtine?
    @Binding var selectedCellIndex: Int?
    @State var days: [Int: String]?
    
    init(
        start: String,
        routine: Binding<Youtine?>,
        selectedCellIndex: Binding<Int?>
    ) {
        self.start = start
        self._routine = routine
        self._selectedCellIndex = selectedCellIndex
    }
    
    func getFontWeight(day: String) -> Font.Weight {
        guard let containsDay = days?.contains(where: { (key: Int, value: String) in
            value == day
        }) else {
            return .regular
        }
        
        if containsDay {
            return .bold
        } else {
            return .regular
        }
    }
    
    var body: some View {
        VStack {
            // Routine title
            HStack(alignment: .center) {
                Text("Details")
                    .font(
                        .system(
                            size: 30,
                            weight: .light
                        )
                    )
                Spacer()
                ExpandedDetailToolbarView(
                    routine: $routine,
                    selectedCellIndex: $selectedCellIndex
                )
            }
            .padding(.bottom, 10)
                        
            // Start time strip
            HStack {
                Text("Start Time")
                Image(systemName: "clock")
                Spacer()
                Text(start)
            }
            .padding(.leading, 20)
            Divider()
            // Start time strip
            HStack {
                Text("Days Assigned")
                Image(systemName: "calendar")
                Spacer()
                // Create days component here
                HStack {
                    Text("M")
                        .fontWeight(getFontWeight(day: "M"))
                        .underline(
                            getFontWeight(day: "M") == .bold ? true : false,
                            pattern: .solid
                        )
                    Text("T")
                        .fontWeight(getFontWeight(day: "T"))
                        .underline(
                            getFontWeight(day: "T") == .bold ? true : false,
                            pattern: .solid
                        )
                    Text("W")
                        .fontWeight(getFontWeight(day: "W"))
                        .underline(
                            getFontWeight(day: "W") == .bold ? true : false,
                            pattern: .solid
                        )
                    Text("Th")
                        .fontWeight(getFontWeight(day: "Th"))
                        .underline(
                            getFontWeight(day: "Th") == .bold ? true : false,
                            pattern: .solid
                        )
                    Text("F")
                        .fontWeight(getFontWeight(day: "F"))
                        .underline(
                            getFontWeight(day: "F") == .bold ? true : false,
                            pattern: .solid
                        )
                    Text("Sa")
                        .fontWeight(getFontWeight(day: "Sa"))
                        .underline(
                            getFontWeight(day: "Sa") == .bold ? true : false,
                            pattern: .solid
                        )
                    Text("S")
                        .fontWeight(getFontWeight(day: "S"))
                        .underline(
                            getFontWeight(day: "S") == .bold ? true : false,
                            pattern: .solid
                        )
                }
                .font(.system(size: 15))
            }
            .onAppear {
                if let validRoutine = self.routine {
                    let decodedDays = Youtine.decodeDays(validRoutine.daysJSON)
                    days = decodedDays
                }
            }
            .padding(.leading, 20)
        }
        .padding(25)
        .padding(.top, 0)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedDetailView(
        start: "8:00 AM", routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
