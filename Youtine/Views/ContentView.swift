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
                    height: selectedCellIndex != nil ? height*0.85 : height
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
