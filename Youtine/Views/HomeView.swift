//
//  HomeView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var routines: [Youtine?]
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    
    var body: some View {
        HeaderView()
        .transition(.move(edge: .leading))
        
        CardsView(
            routines: $routines,
            selectedCellIndex: $selectedCellIndex
        )
        .transition(.move(edge: .leading))
    }
}

#Preview {
    HomeView(
        routines: .constant(testRoutines),
        selectedCellIndex: .constant(0)
    )
}
