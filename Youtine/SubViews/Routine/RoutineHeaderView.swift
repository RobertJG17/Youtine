//
//  ExpandedHeader.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct RoutineHeaderView: View {
    @Binding var title: String

    @Environment(UIStore.self) var uiStore
    
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
            .padding(.bottom, 20)
        }
        .frame(height: uiStore.screenHeight*0.20)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            // MARK: NAVIGATE TO .home
            uiStore.updatePage(to: .home)
        }
        .padding(.horizontal, 20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoutineHeaderView(
        title: .constant("Morning Routine")
    )
}
