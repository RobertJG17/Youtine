//
//  HeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        Text("Youtine")
            .font(
                .system(
                    size: 50,
                    weight: .ultraLight,
                    design: .rounded
                )
            )
            .frame(maxWidth: .infinity, maxHeight: screenHeight.wrappedValue / 7)
            .underline(
                true,
                pattern: .solid
            )
            .preferredColorScheme(.dark)
    }
}

#Preview {
    HeaderView()
}
