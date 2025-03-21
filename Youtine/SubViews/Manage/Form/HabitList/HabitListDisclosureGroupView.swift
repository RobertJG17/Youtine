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
    
    @State private var isExpanded: Bool = false
    
    @Environment(UIStore.self) var uiStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            
            DisclosureGroup(isExpanded: $isExpanded) {
                Text(desc)
                    .font(.caption)
                    .fontWeight(.light)
                    // ???: Allow multiline text
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(
                        width: uiStore.screenWidth / 1.75,
                        alignment: .leading
                    )
                    .transition(.opacity)
            } label: {
                // MARK: Truncated description with ellipsis when collapsed
                if !isExpanded {
                    Text(desc)
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(isExpanded ? nil : 1) // Set to nil when expanded
                        .truncationMode(.tail)
                        .frame(
                            width: uiStore.screenWidth / 2.0,
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
        desc: ""
    )
}
