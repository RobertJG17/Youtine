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
    
    @Environment(UIStore.self) var uiStore
    
    init(
        index: Int,
        borderColor: Color
    ) {
        self.index = index
        self.borderColor = borderColor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    width: uiStore.screenWidth*0.90,
                    height: uiStore.screenHeight / 4
                )
                .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                .foregroundStyle(Color.black)
            
            HStack(alignment: .center) {
                Image(systemName: "plus")
                    .font(.system(size: 40))
            }
            .frame(
                width: uiStore.screenWidth*0.90,
                height: uiStore.screenHeight / 4
            )
            .background(Color.clear) // Give the Spacer a tappable area
            .contentShape(Rectangle()) // Ensure the entire area is tappable
            .onTapGesture {
                // MARK: NAVIGATE TO .createRoutine
                uiStore.updatePage(to: .createRoutine)
                
                // MARK: SET selectedCellIndex
                uiStore.updateSelectedCellIndex(to: index)
            }
            .contentShape(Rectangle())
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EmptyCardView(
        index: 0,
        borderColor: .white
    )
}
