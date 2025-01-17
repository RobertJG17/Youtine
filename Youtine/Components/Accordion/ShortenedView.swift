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
        height: CGFloat
    ) {
        self.index = index
        self._selectedCellIndex = selectedCellIndex
        self.title = routine.title
        self.start = routine.start
        self.todos = routine.todos
        self.borderColor = Color.from(description: routine.borderColor)
        self.height = height
    }
    
    var body: some View {
        // card start
        VStack {
            Spacer()
            HStack() {
                Text(title)
                    .font(
                        .system(
                            size: 25,
                            weight: .light
                        )
                    )
                Spacer()
                Image(systemName: "chevron.down")
            }
            Spacer()
            Divider()
            Spacer()
            HStack {
                Text("Start Time: ")
                    .fontWeight(.thin)
                Spacer()
                Text(start)
                    .fontWeight(.thin)
            }
            HStack {
                Text("Tasks Completed: ")
                    .fontWeight(.thin)
                Spacer()
                Text("\(tasksCompleted)/\(todos.count)")
                    .fontWeight(.thin)
            }
            Spacer()
        }
        .padding(50)
        .frame(height: height / 4)
        .frame(maxWidth: .infinity)
        .background(Color.clear) // Give the Spacer a tappable area
        .contentShape(Rectangle()) // Ensure the entire area is tappable
        .onTapGesture {
            if selectedCellIndex == nil {
                selectedCellIndex = index
            }
        }
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
        selectedCellIndex: .constant(0),
        routine: testRoutines[0],
        height: 687.6666666666667
    )
}
