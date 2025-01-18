//
//  ShortenedView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

struct ShortenedView: View {
    @State var createRoutine: Bool = false
    
    var index: Int
    @Binding var selectedCellIndex: Int?
    var title: String
    var start: String
    var habits: [Habit]
    var height: CGFloat
    var width: CGFloat
    var borderColor: Color
    var routineCreated: Bool
    
    // MARK: Computed Properties [START]
    var habitsCompleted: Int {
        return habits.reduce(0) { partialResult, todo in
            partialResult + (todo.completed ? 1 : 0)
        }
    }

    // MARK: Computed Properties [END]
    
    init(
        index: Int,
        selectedCellIndex: Binding<Int?>,
        routine: Youtine?,
        height: CGFloat,
        width: CGFloat
    ) {
        self.index = index
        self._selectedCellIndex = selectedCellIndex
        self.title = routine?.title ?? ""
        self.start = routine?.start ?? ""
        self.habits = routine?.habits ?? []
        self.height = height
        self.width = width
        
        self.borderColor = Color.from(
            description: routine?.borderColor ?? "white"
        )
        self.routineCreated = routine != nil
    }
    
    var body: some View {
        // card start
        ZStack {
            if createRoutine {
                CreateRoutineView(
                    index: index,
                    width: width,
                    height: height,
                    createRoutine: $createRoutine
                )
                .transition(
                    .asymmetric(
                        insertion: .scale,
                        removal: .scale
                    )
                )
            } else if routineCreated {
                ZStack {
                    Rectangle()
                        .frame(width: width*0.90, height: height / 4)
                        .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                        .foregroundStyle(Color.black)
                    
                    VStack {
                        Spacer()
                        
                        ShortenedHeader(
                            title: title
                        )
                        
                        Divider()
                        
                        Spacer()
                        
                        ShortenedDetailView(
                            start: start,
                            habitsCompleted: habitsCompleted,
                            habits: habits
                        )
                    }
                    .padding(50)
                    .frame(width: width*0.90, height: height / 4)
                    .preferredColorScheme(.dark)
                }
                .frame(width: width*0.90, height: height / 4)
                .background(Color.clear) // Give the Spacer a tappable area
                .contentShape(Rectangle()) // Ensure the entire area is tappable
                .onTapGesture {
                    selectedCellIndex = index
                }
                .background(Color.black)
                
            } else {
                
                Rectangle()
                    .frame(width: width*0.90, height: height / 4)
                    .shadow(color: borderColor, radius: 0.5, x: 5, y: 5)
                
                HStack(alignment: .center) {
                    Image(systemName: "plus")
                        .font(.system(size: 40))
                }
                .frame(width: width*0.90, height: height / 4)
                .background(Color.clear) // Give the Spacer a tappable area
                .contentShape(Rectangle()) // Ensure the entire area is tappable
                .onTapGesture {
                    // MARK: Close create routine view
                    createRoutine.toggle()
                    selectedCellIndex = index
                }
                .transition(
                    .asymmetric(
                        insertion: .scale,
                        removal: .scale
                    )
                )
                .contentShape(Rectangle())
                
            }
        }
        .animation(.easeInOut, value: createRoutine)
        .preferredColorScheme(.dark)
        
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
