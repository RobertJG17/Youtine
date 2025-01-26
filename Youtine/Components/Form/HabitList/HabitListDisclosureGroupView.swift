//
//  HabitListDisclosureGroupView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/24/25.
//

import SwiftUI

struct HabitListDisclosureGroupView: View {
    var label: String
    var desc: String
    @Binding var locked: Bool
    
    @State private var isExpanded: Bool = false
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label) // Label stays static
            
            DisclosureGroup(isExpanded: $isExpanded) {
                if !locked {
                    Text(desc)
                        .font(.caption)
                        .fontWeight(.light)
                        .fixedSize(horizontal: false, vertical: true) // Allow multiline text
                        .frame(
                            width: screenWidth.wrappedValue / 3.0,
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
        .ignoresSafeArea(edges: .leading)
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
        locked: .constant(false)
    )
}
