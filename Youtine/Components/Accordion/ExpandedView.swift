//
//  OpenView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ExpandedView: View {
    @State var showScrollIndicator: Bool = true
    @State var animatedOpacity: CGFloat = 1
    var index: Int
    @Binding var selectedCellIndex: Int?
    var title: String
    var days: [String]
    var start: String
    var todos: [Todo]
    var height: CGFloat
    var borderColor: Color
    var tasksCompleted: Int {
        return todos.reduce(0) { partialResult, todo in
            partialResult + (todo.completed ? 1 : 0)
        }
    }
    var backgroundImage: String {
        switch(index) {
        case 0:
            return "morning"
        case 1:
            return "noon"
        case 2:
            return "night"
        default:
            return "morning"
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
        self.days = routine.days
        self.start = routine.start
        self.todos = routine.todos
        self.height = height
        self.borderColor = Color.from(description: routine.borderColor)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // Routine title
                HStack(spacing: 0) {
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
            }
                .frame(maxWidth: .infinity)
                .background(Color.clear) // Give the Spacer a tappable area
                .contentShape(Rectangle()) // Ensure the entire area is tappable
                .onTapGesture {
                    selectedCellIndex = nil
                }
                .padding(.leading, 25)
                .padding(.trailing, 25)
            
            VStack(spacing: 0) {
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
                    
                    // Start time strip
                    HStack {
                        Text("Start Time")
                        Image(systemName: "clock")
                        Spacer()
                        Text(start)
                    }
                    .padding(.leading, 20)
                    
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
                
                Spacer()
                
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
            }
            
            .overlay(
                Image(backgroundImage)
                    .resizable()
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .horizontal)
            )
            .overlay(
                VStack {
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                    Spacer()
                    Rectangle()
                        .fill(borderColor)
                        .frame(height: 1)
                }
            )
            .frame(height: height*0.85)
            .padding(.bottom, 100)
            .preferredColorScheme(.dark)
        }
    }
    
}

#Preview {
    ExpandedView(
        index: 0,
        selectedCellIndex: .constant(0),
        routine: testRoutines[0],
        height: 687.6666666666667
    )
}
