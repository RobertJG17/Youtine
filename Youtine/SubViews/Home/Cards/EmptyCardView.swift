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
    
    @Environment(RoutineEnvironment.self) var environmentContext
    
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
                    width: environmentContext.screenWidth*0.90,
                    height: environmentContext.screenHeight / 4
                )
                .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                .foregroundStyle(Color.black)
            
            HStack(alignment: .center) {
                Image(systemName: "plus")
                    .font(.system(size: 40))
            }
            .frame(
                width: environmentContext.screenWidth*0.90,
                height: environmentContext.screenHeight / 4
            )
            .background(Color.clear) // Give the Spacer a tappable area
            .contentShape(Rectangle()) // Ensure the entire area is tappable
            .onTapGesture {
                // MARK: NAVIGATE TO .createRoutine
                environmentContext.updatePage(to: .createRoutine)
                
                // MARK: SET selectedCellIndex
                environmentContext.updateSelectedCellIndex(to: index)
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
