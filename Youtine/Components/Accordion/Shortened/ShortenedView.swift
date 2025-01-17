//
//  ShortenedView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ShortenedView: View {
    var index: Int
    @Binding var selectedCellIndex: Int?
    var title: String
    var start: String
    var todos: [Todo]
    var height: CGFloat
    var width: CGFloat
    var borderColor: Color
    var tasksCompleted: Int {
        return todos.reduce(0) { partialResult, todo in
            partialResult + (todo.completed ? 1 : 0)
        }
    }
    
    init(
        index: Int,
        selectedCellIndex: Binding<Int?>,
        routine: Youtine,
        height: CGFloat,
        width: CGFloat
    ) {
        self.index = index
        self._selectedCellIndex = selectedCellIndex
        self.title = routine.title
        self.start = routine.start
        self.todos = routine.todos
        self.height = height
        self.width = width
        self.borderColor = Color.from(description: routine.borderColor)
    }
    
    var body: some View {
        // card start
        ZStack {
            Rectangle()
                .fill(Color.black)
                .shadow(color: borderColor, radius: 0.5, x: 5, y: 5) // Shadow properties
            
            VStack {
                Spacer()
                
                ShortenedHeader(
                    title: title
                )
                
                Divider()
                
                Spacer()
                
                ShortenedDetailView(
                    start: start,
                    tasksCompleted: tasksCompleted,
                    todos: todos
                )
            }
            .padding(50)
            .preferredColorScheme(.dark)
            
        }
        .frame(width: width*0.90, height: height / 4)
        .background(Color.clear) // Give the Spacer a tappable area
        .contentShape(Rectangle()) // Ensure the entire area is tappable
        .onTapGesture {
            if selectedCellIndex == nil {
                selectedCellIndex = index
            }
        }
    }
}

#Preview {
    ShortenedView(
        index: 0,
        selectedCellIndex: .constant(0),
        routine: testRoutines[0],
        height: 687.6666666666667,
        width: 402.0
    )
}
