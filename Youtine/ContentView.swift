//
//  ContentView.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    static private let MAX_ROUTINE_COUNT = 3

    @Query var savedRoutines: [Youtine]
    
    @State var localRoutines: [Youtine?] = Array(repeating: nil, count: MAX_ROUTINE_COUNT)
    
    // MARK: Routines - MORNING | AFTERNOON | EVENING
    let MAX_ROUTINES: Int = 3
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                Router(
                    width: width,
                    height: height,
                    routines: $localRoutines
                )
            }
        }
        .onAppear {
            // MARK: Set local state to array with youtines and nil entries otherwise
            localRoutines = savedRoutines +
                Array.init(
                    repeating: nil,
                    count: MAX_ROUTINES - savedRoutines.count
                )
            
            // on appear if array is empty should I store?
            // or should I wait till a single routine is provisioned?
        }
        .onChange(of: savedRoutines, { oldValue, newValue in
            print("OLD ROUTINES: ", oldValue)
            print("NEW ROUTINES: ", newValue)
        })
        
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
