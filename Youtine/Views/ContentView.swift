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
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                VStack(alignment: .center) {
                    Text("Youtine")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(color: Color.yellow, radius: 1, x: 2, y: 2)
                        .underline(true, pattern: .solid)
                    
                    // Use For Each
                    
                    ForEach(routines) { routine in
                        RoutineView(
                            title: routine.title,
                            start: routine.start,
                            height: height,
                            borderColor: routine.borderColor
                        )
                        
                        Spacer()
                    }
                }
                .frame(width: width, height: height)
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView(routines:
        [
            Youtine(
                start: "8:00 am",
                title: "Morning Routine",
                todos: [
                    Todo(label: "Wash Face", desc: "Use cetaphil cleanser"),
                    Todo(label: "Shave", desc: "Slow manual shave"),
                    Todo(label: "Moisture", desc: "Use moisturizer with SPF 50 minimum")
                ],
                borderColor: .yellow
            ),
            Youtine(
                start: "12:00 pm",
                title: "Afternoon Routine",
                todos: [
                    Todo(label: "Wash Face", desc: "Use cetaphil cleanser"),
                    Todo(label: "Shave", desc: "Slow manual shave"),
                    Todo(label: "Moisture", desc: "Use moisturizer with SPF 50 minimum")
                ],
                borderColor: .blue
            ),
            Youtine(
                start: "8:00 pm",
                title: "Night Routine",
                todos: [
                    Todo(label: "Wash Face", desc: "Use cetaphil cleanser"),
                    Todo(label: "Shave", desc: "Slow manual shave"),
                    Todo(label: "Moisture", desc: "Use moisturizer with SPF 50 minimum")
                ],
                borderColor: .red
            )
        ]
    )
}
