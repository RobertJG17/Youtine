//
//  ShortenedHeader.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardHeaderView: View {
    var title: String
    
    var body: some View {
        HStack() {
            Text(title)
                .font(
                    .system(
                        size: 25,
                        weight: .light
                    )
                )
                .shadow(color: Color.clear, radius: 0.5)
            Spacer()
            Image(systemName: "chevron.down")
        }
        Spacer()
    }
}

#Preview {
    CardHeaderView(title: "Morning Routine")
}
