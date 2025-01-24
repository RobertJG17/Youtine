//
//  EmptyCardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct EmptyCardView: View {
    var index: Int
    var borderColor: Color
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    init(
        index: Int,
        borderColor: Color,
        selectedCellIndex: Binding<Int?>
    ) {
        self.index = index
        self.borderColor = borderColor
        self._selectedCellIndex = selectedCellIndex
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: screenWidth.wrappedValue*0.90, height: screenHeight.wrappedValue / 4)
                .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                .foregroundStyle(Color.black)
            
            HStack(alignment: .center) {
                Image(systemName: "plus")
                    .font(.system(size: 40))
            }
            .frame(width: screenWidth.wrappedValue*0.90, height: screenHeight.wrappedValue / 4)
            .background(Color.clear) // Give the Spacer a tappable area
            .contentShape(Rectangle()) // Ensure the entire area is tappable
            .onTapGesture {
                /// MARK: NAVIGATE TO .createRoutine
                currentPage.wrappedValue = .createRoutine
                
                /// MARK: SET selectedCellIndex index
                selectedCellIndex = index
            }
            .transition(
                .asymmetric(
                    insertion: .scale,
                    removal: .scale
                )
            )
            .contentShape(Rectangle())
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EmptyCardView(
        index: 0,
        borderColor: .white,
        selectedCellIndex: .constant(0)
    )
}
