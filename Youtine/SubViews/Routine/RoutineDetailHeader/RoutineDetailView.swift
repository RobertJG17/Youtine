//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct RoutineDetailView: View {
    @Binding var start: String
    @Binding var days: [Int: String]
    
    @Environment(UIStore.self) var uiStore
    
    func getFontWeight(day: String) -> Font.Weight {
        let containsDay = days.contains(where: { (key: Int, value: String) in
            value == day
        })
        
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
                RoutineDetailToolbarView()
            }
            
            Rectangle()
                .frame(
                    width: uiStore.screenWidth*0.9,
                    height: 0.3
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                        
            HStack {
                Text("Start Time")
                Image(systemName: "clock")
                Spacer()
                Text(start)
            }
            
            Divider()
            
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
                if let routine = uiStore.selectedRoutine {
                    let decodedDays = Routine.decodeDays(routine.daysJSON)
                    days = decodedDays
                }
            }
        }
        .padding(25)
        .padding(.top, 15)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoutineDetailView(start: .constant("8:00 AM"), days: .constant([:]))
}
