//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // I have to include code to query these routines
    // If no routine exists, I can create 3 plus buttons instead of Routine
    // views
    var routines: [Youtine]
    let MAX_ROUTINE_COUNT: Int = 3
    
    @State var selectedCellIndex: Int? = nil
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                VStack(alignment: .center) {
                    HeaderView(
                        width: width,
                        selectedCellIndex: selectedCellIndex
                    )
                    .animation(.easeInOut, value: selectedCellIndex)
                    
                    Spacer()
                    
                    RoutinesView(
                        selectedCellIndex: $selectedCellIndex,
                        routines: routines,
                        height: height,
                        width: width
                    )
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
