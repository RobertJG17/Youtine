//
//  HabitListDisclosureGroupView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/24/25.
//

import SwiftUI

// MARK: This View is being leveraged in both RoutineHabitListView & HabitListView
// MARK: RoutineHabitListView is rendered when viewing an existing Routine
// MARK: HabitListView is rendered when editing an existing Routine or creating a new Routine
struct HabitListDisclosureGroupView: View {
    var label: String
    var desc: String
    @Binding var disclosureExpansionLocked: Bool
    
    @State private var isExpanded: Bool = false
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label) // Label stays static
            
            DisclosureGroup(isExpanded: $isExpanded) {
                if !disclosureExpansionLocked {
                    Text(desc)
                        .font(.caption)
                        .fontWeight(.light)
                        .fixedSize(horizontal: false, vertical: true) // Allow multiline text
                        .frame(
                            width: screenWidth.wrappedValue / 1.75,
                            alignment: .leading
                        )
                        .transition(.opacity)
                }
            } label: {
                // Truncated description with ellipsis when collapsed
                if !isExpanded {

                    Text(desc)
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(isExpanded ? nil : 1) // Set to nil when expanded
                        .truncationMode(.tail)
                        .frame(
                            width: screenWidth.wrappedValue / 2.0,
                            alignment: .leading
                        )
                        .transition(.opacity)
                }
            }
        }
        .contentShape(Rectangle())
        .background(Color.clear)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle() // Toggle expansion on tap
            }
        }
    }
}

#Preview {
    HabitListDisclosureGroupView(
        label: "",
        desc: "",
        disclosureExpansionLocked: .constant(false)
    )
}
