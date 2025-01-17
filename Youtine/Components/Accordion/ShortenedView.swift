//
//  ShortenedView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ShortenedView: View {
    var index: Int
    var title: String
    var start: String
    var todos: [Todo]
    var height: CGFloat
    var borderColor: Color
    
    init(
        index: Int,
        title: String,
        start: String,
        todos: [Todo],
        height: CGFloat,
        borderColor: String
    ) {
        self.index = index
        self.title = title
        self.start = start
        self.todos = todos
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
                .background(borderColor)
                .fontWeight(.bold)
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
                .strokeBorder(
                    borderColor,
                    style: StrokeStyle(
                        lineWidth: 1.5,
                        dash: [30, 1]
                    )
                )
        )
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ShortenedView(
        index: 0,
        title: "Morning Routine",
        start: "8:00 a.m.",
        todos: testRoutines[0].todos,
        height: 500,
        borderColor: "red"
    )
}
