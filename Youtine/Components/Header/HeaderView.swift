//
//  HeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct HeaderView: View {
    var width: CGFloat
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
            .frame(width: width)
            .padding(.bottom, 10)
            .underline(
                true,
                pattern: .solid
            )
            .preferredColorScheme(.dark)
            .opacity(
                selectedCellIndex == nil ? 1 : 0
            )
            .transition(
                .asymmetric(
                    insertion: .slide,
                    removal: .scale.combined(with: .opacity)
                )
            )
    }
}

#Preview {
    HeaderView(width: 400, selectedCellIndex: nil)
}
