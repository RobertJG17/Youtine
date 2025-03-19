//
//  CustomColorPicker.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var routineColor: Color
    
    let MAX_COUNT = Color.validColors.count
    
    @Environment(RoutineEnvironment.self) var environmentContext
    
    var body: some View {
        let rows = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
        
        LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
            ForEach(Array(Color.validColors.enumerated()), id: \.offset) { index, color in
                ZStack {
                    if routineColor == color {
                        Rectangle()
                            .border(.white)
                            .frame(
                                width: environmentContext.screenWidth / CGFloat(MAX_COUNT),
                                height: environmentContext.screenWidth / CGFloat(MAX_COUNT)
                            )
                            .transition(.scale)
                    }

                    Rectangle()
                        .frame(
                            width: environmentContext.screenWidth / CGFloat(MAX_COUNT) - 10,
                            height: environmentContext.screenWidth / CGFloat(MAX_COUNT) - 10
                        )
                        .onTapGesture {
                            routineColor = color
                        }
                        .foregroundStyle(color)
                        
                }
                .animation(.easeInOut, value: routineColor)
            }
        }
        
        .frame(
            width: environmentContext.screenWidth*0.9,
            height: environmentContext.screenHeight*0.2
        )
        .contentShape(RoundedRectangle(cornerRadius: 40))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CustomColorPicker(
        routineColor: .constant(.red)
    )
}
