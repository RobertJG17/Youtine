//
//  RoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/13/25.
//

import SwiftUI

struct RoutineView: View {
    var title: String
    var start: String
    var height: CGFloat
    var borderColor: Color
    
    init(
        title: String,
        start: String,
        height: CGFloat,
        borderColor: String
    ) {
        self.title = title
        self.start = start
        self.height = height
        self.borderColor = Color.from(description: borderColor)
    }
    
    var body: some View {
        // card start
        VStack {
            Spacer()
            HStack() {
                Text(title)
                Spacer()
                Text(start)
            }
            Spacer()
            Divider()
            Spacer()
            HStack {
                // This text is static
                Text("Tasks completed")
                Spacer()
                
                // We will get this from summing our completed property
                // per todo within a single routine
                Text("2/3")
            }
            Spacer()
        }
        .padding(50)
        .frame(height: height / 4)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 2)
        )
        .preferredColorScheme(.dark)
        // card end
    }
}

#Preview {
    RoutineView(
        title: "Morning Routine",
        start: "8:00 am",
        height: 600,
        borderColor: "red"
    )
}
