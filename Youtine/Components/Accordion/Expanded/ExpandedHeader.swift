//
//  ExpandedHeader.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedHeader: View {
    var height: CGFloat
    var title: String
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    
    init(
        height: CGFloat,
        title: String,
        selectedCellIndex: Binding<Int?>
    ) {
        self.height = height
        self.title = title
        self._selectedCellIndex = selectedCellIndex
    }
    
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
        .frame(height: height*0.1)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            /// MARK: NAVIGATE TO .home
            currentPage.wrappedValue = .home
            
            /// MARK: SET selectedCellIndex nil
            selectedCellIndex = nil            
        }
        .padding(.top, 100)
        .padding(.horizontal, 20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedHeader(
        height: 687.666666667,
        title: "Morning Routine",
        selectedCellIndex: .constant(1)
    )
}
