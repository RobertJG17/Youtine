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
        routine: Youtine?,
        selectedCellIndex: Binding<Int?>
    ) {
        self.height = height
        self.title = routine?.title ?? "Routine"
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
            // MARK: selectedCellIndex set to nil
            selectedCellIndex = nil
            
            // MARK: Navigation
            currentPage.wrappedValue = .home
        }
        .padding(.top, 100)
        .padding(.horizontal, 20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedHeader(
        height: 687.666666667,
        routine: testRoutines[0]!,
        selectedCellIndex: .constant(1)
    )
}
