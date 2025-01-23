//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedDetailView: View {
    var start: String
    @Binding var routine: Youtine?
    @Binding var selectedCellIndex: Int?
    
    var body: some View {
        VStack {
            // Routine title
            HStack(alignment: .center) {
                Text("Details")
                    .font(
                        .system(
                            size: 30,
                            weight: .light
                        )
                    )
                Spacer()
                ExpandedDetailToolbarView(
                    routine: $routine,
                    selectedCellIndex: $selectedCellIndex
                )
            }
            .padding(.bottom, 10)
                        
            // Start time strip
            HStack {
                Text("Start Time")
                Image(systemName: "clock")
                Spacer()
                Text(start)
            }
            .padding(.leading, 20)
            Divider()
            // Start time strip
            HStack {
                Text("Days Assigned")
                Image(systemName: "calendar")
                Spacer()
                // Create days component here
            }
            .padding(.leading, 20)
        }
        .padding(25)
        .padding(.top, 0)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ExpandedDetailView(
        start: "8:00 AM", routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
