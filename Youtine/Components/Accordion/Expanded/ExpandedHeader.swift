//
//  ExpandedHeader.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedHeader: View {
    var title: String
    @Binding var selectedCellIndex: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            // Routine title
            HStack(spacing: 0) {
                Text(title)
                    .font(
                        .system(
                            size: 40,
                            weight: .ultraLight
                        )
                    )
                Spacer()
                Image(systemName: "chevron.up")
            }
            
        }
            .frame(maxWidth: .infinity)
            .background(Color.clear) // Give the Spacer a tappable area
            .contentShape(Rectangle()) // Ensure the entire area is tappable
            .onTapGesture {
                selectedCellIndex = nil
            }
            .padding(.leading, 25)
            .padding(.trailing, 25)
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedHeader(
        title: "Morning Routine",
        selectedCellIndex: .constant(1)
    )
}
