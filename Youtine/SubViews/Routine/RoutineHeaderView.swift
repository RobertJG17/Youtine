//
//  ExpandedHeader.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct RoutineHeaderView: View {
    var title: String
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.screenHeight) var screenHeight
    
    init(
        title: String,
        selectedCellIndex: Binding<Int?>
    ) {
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
        .frame(height: screenHeight.wrappedValue*0.36)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            /// MARK: NAVIGATE TO .home
            currentPage.wrappedValue = .home
        }
        .padding(.horizontal, 20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoutineHeaderView(
        title: "Morning Routine",
        selectedCellIndex: .constant(1)
    )
}
