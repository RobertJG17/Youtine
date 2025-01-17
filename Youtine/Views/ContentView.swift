//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var routines: [Youtine]
    @State var selectedCellIndex: Int? = nil
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                VStack(alignment: .center) {
                    Text("Youtine")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: width)
                        .padding(.bottom, 10)
                        .background(Color.indigo)
                        .shadow(
                            color: Color.yellow,
                            radius: 1,
                            x: 2,
                            y: 2
                        )
                        .underline(
                            true,
                            pattern: .solid
                        )
                    
                    // Use For Each
                    Spacer()
                    
                    ForEach(Array(routines.enumerated()), id: \.element) { index, routine in
                        
                        RoutineView(
                            index: index,
                            selectedCellIndex: $selectedCellIndex,
                            title: routine.title,
                            start: routine.start,
                            todos: routine.todos,
                            height: height,
                            borderColor: routine.borderColor
                        )
                        
                        
                        if selectedCellIndex == nil {
                            Spacer()
                        } else if (selectedCellIndex != nil) &&
                                    selectedCellIndex == index {
                            Spacer()
                        } else {
                            Spacer()
                        }
                    }
                }
                .frame(
                    width: width,
                    height: height
                )
                .background()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView(
        routines: testRoutines
    )
}
