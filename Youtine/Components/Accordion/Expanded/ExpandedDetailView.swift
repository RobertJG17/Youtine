//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ExpandedDetailView: View {
    var start: String
    
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
    ExpandedDetailView(start: "8:00 AM")
}
