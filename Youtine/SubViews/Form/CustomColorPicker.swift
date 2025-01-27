//
//  CustomColorPicker.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/20/25.
//

import SwiftUI

struct CustomColorPicker: View {
    var width: CGFloat
    var height: CGFloat
    @Binding var routineColor: Color
    
    let MAX_COUNT = Color.validColors.count
    
    var body: some View {
        let rows = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
        
        LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
            ForEach(Array(Color.validColors.enumerated()), id: \.offset) { index, color in
                ZStack {
                    if routineColor == color {
                        Rectangle()
                            .border(.white)
                            .frame(
                                width: width / CGFloat(MAX_COUNT),
                                height: width / CGFloat(MAX_COUNT)
                            )
                            .transition(.scale)
                    }

                    Rectangle()
                        .frame(
                            width: width / CGFloat(MAX_COUNT) - 10,
                            height: width / CGFloat(MAX_COUNT) - 10
                        )
                        .onTapGesture {
                            routineColor = color
                        }
                        .foregroundStyle(color)
                        
                }
                .animation(.easeInOut, value: routineColor)
            }
        }
        
        .frame(width: width*0.9, height: height*0.2)
        .contentShape(RoundedRectangle(cornerRadius: 40))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CustomColorPicker(
        width: 402.0,
        height: 687.66666667,
        routineColor: .constant(.red)
    )
}
