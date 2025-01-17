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
                    
                    ForEach(Array(routines.enumerated()), id: \.element) { index, routine in
                        RoutineView(
                            index: index,
                            selectedCellIndex: $selectedCellIndex,
                            routine: routine,
                            height: height
                        )
                        
                        if selectedCellIndex == nil {
                            Spacer()
                        } else if (selectedCellIndex != nil) &&
                                    selectedCellIndex == index {
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
