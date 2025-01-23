//
//  HomeView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct HomeView: View {
    var width: CGFloat
    var height: CGFloat
    var routines: [Youtine?]
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    
    var body: some View {
        HeaderView(
            width: width,
            height: height
        )
        .transition(.move(edge: .leading))
        
        CardsView(
            width: width,
            height: height,
            routines: routines,
            selectedCellIndex: $selectedCellIndex
        )
        .transition(.move(edge: .leading))
    }
}

#Preview {
    HomeView(
        width: 402.0,
        height: 687.6666666667,
        routines: testRoutines,
        selectedCellIndex: .constant(0)
    )
}
