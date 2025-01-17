//
//  OpenView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ExpandedView: View {
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
            VStack {
                // Routine title
                HStack {
                    Text(title)
                        .font(
                            .system(
                                size: 40,
                                weight: .light
                            )
                        )
                    
                    Spacer()
                }
                
                Spacer()
                
                // Start time strip
                HStack {
                    Text("Start Time")
                    Image(systemName: "clock")
                    Spacer()
                    Text(start)
                }
                
                Spacer()
                Divider()
                    .background(borderColor)
                    .fontWeight(.bold)
                Spacer()
                
                // Tasks completed strip
                HStack {
                    // This text is static
                    Text("Tasks Completed")
                    Image(systemName: "checkmark")
                    Spacer()
                    
                    // We will get this from summing our completed property
                    // per todo within a single routine
                    Text("2/3")
                }
            }
            .padding(25)
            
            List(todos, id: \.id) { todo in
                let completed = todo.completed
                let desc = todo.desc
                let label = todo.label
                let labelImage = completed ? "circle.fill" : "circle"
    
                
                Button {
                    todo.completed.toggle()
                } label: {
                    HStack {
                        Image(systemName: labelImage)
                        VStack(alignment: .leading) {
                            Text(label)
                            Text(desc)
                                .font(.caption)
                        }
                    }
                    .foregroundStyle(Color.white)
                }
            }
            
            // maybe there's an alternative to negative padding...
            .padding(.top, -35)
        }
        
        .frame(height: height*0.8)
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
    ExpandedView(
        index: 0,
        title: "Morning Routine",
        start: "8:00 a.m.",
        todos: testRoutines[0].todos,
        height: 500,
        borderColor: "red"
    )
}
