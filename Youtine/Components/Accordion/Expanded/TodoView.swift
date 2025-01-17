//
//  TodoView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct TodoView: View {
    @State var showScrollIndicator: Bool = true
    @State var animatedOpacity: CGFloat = 1
    var todos: [Todo]
    var height: CGFloat
    var tasksCompleted: Int {
        return todos.reduce(0) { partialResult, todo in
            partialResult + (todo.completed ? 1 : 0)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Routine title
            HStack(alignment: .center) {
                Text("Tasks")
                    .font(
                        .system(
                            size: 30,
                            weight: .light
                        )
                    )
                Spacer()
            }
            .padding(.leading, 25)
            
            List(todos, id: \.id) { todo in
                let completed = todo.completed
                let desc = todo.desc
                let label = todo.label
                let labelImage = completed ? "checkmark.circle.fill" : "circle"
                
                
                Button {
                    todo.completed.toggle()
                } label: {
                    HStack {
                        Image(systemName: labelImage)
                            .animation(.bouncy)
                        VStack(alignment: .leading) {
                            Text(label)
                            Text(desc)
                                .font(.caption)
                                .fontWeight(.light)
                        }
                    }
                    .foregroundStyle(Color.white)
                    .onAppear{
                        guard let lastTodo: Todo = todos.last else { return }
                        
                        if todo.id == lastTodo.id {
                            showScrollIndicator = false
                        }
                        
                    }
                    .onDisappear {
                        guard let lastTodo: Todo = todos.last else { return }
                        
                        if todo.id == lastTodo.id {
                            showScrollIndicator = true
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(height: height/2.3)
            .padding(.leading, 5)
            
            VStack {
                HStack{
                    Spacer()
                    Image(systemName: "chevron.down.2")
                        .opacity(
                            showScrollIndicator ?
                            1 : 0
                        )
                        .opacity(animatedOpacity)
                        .animation(
                            .easeInOut(duration: 0.65)
                            .repeatForever(
                                autoreverses: true
                            ),
                            value: animatedOpacity
                        ) // Animate the scale
                        .onAppear {
                            animatedOpacity = 0.5 // Trigger the animation
                        }

                }
                .padding(.bottom, 20)
                HStack {
                    Text("Completed:")
                        .font(
                            .system(
                                size: 30,
                                weight: .light
                            )
                        )
                        .opacity(0.7)
                    Spacer()
                    Text("\(tasksCompleted)/\(todos.count)")
                        .font(
                            .system(
                                size: 30,
                                weight: .light
                            )
                        )
                        .opacity(0.7)
                }
            }
            .padding(25)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    TodoView(
        todos: testRoutines[0].todos,
        height: 687.6666666667
    )
}
