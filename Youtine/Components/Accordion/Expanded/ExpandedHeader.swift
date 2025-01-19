//
//  ExpandedHeader.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedHeader: View {
    var title: String
    var height: CGFloat
    @Binding var selectedCellIndex: Int?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Routine title
            Spacer()
            HStack(alignment: .center, spacing: 0) {
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
        .frame(height: height / 7)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedCellIndex = nil
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedHeader(
        title: "Morning Routine",
        height: 687.666666667,
        selectedCellIndex: .constant(1)
    )
}
