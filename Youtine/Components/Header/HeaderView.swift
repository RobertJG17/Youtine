//
//  HeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct HeaderView: View {
    var width: CGFloat
    var height: CGFloat
    var selectedCellIndex: Int?
    
    var body: some View {
        Text("Youtine")
            .font(
                .system(
                    size: 50,
                    weight: .ultraLight,
                    design: .rounded
                )
            )
            .frame(maxWidth: .infinity, maxHeight: height / 8)
            .underline(
                true,
                pattern: .solid
            )
            .preferredColorScheme(.dark)
            .opacity(
                selectedCellIndex == nil ? 1 : 0
            )
            .transition(.move(edge: .top))
    }
}

#Preview {
    HeaderView(
        width: 400,
        height: 687.6666666667,
        selectedCellIndex: nil
    )
}
