//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var routines: [Youtine?]
    
    @State var selectedCellIndex: Int? = nil
    @State var createRoutine: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                VStack(alignment: .center, spacing: 0) {
                    ZStack {
                        if selectedCellIndex == nil && !createRoutine {
                            HeaderView(
                                width: width,
                                height: height,
                                selectedCellIndex: selectedCellIndex
                            )
                        }
                    }
                    .animation(.easeInOut, value: selectedCellIndex)
                    
                    RoutinesView(
                        selectedCellIndex: $selectedCellIndex,
                        createRoutine: $createRoutine,
                        routines: routines,
                        height: height,
                        width: width
                    )
                }
                .frame(
                    width: width,
                    height: height*0.9
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
