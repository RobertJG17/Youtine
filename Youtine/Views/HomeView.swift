//
//  HomeView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var routines: [Routine?]
        
    var body: some View {
        HeaderView()
        .transition(.move(edge: .top))
        
        CardsView(routines: $routines)
//        .transition(.move(edge: .leading))
            .transition(.blurReplace)
    }
}

#Preview {
    HomeView(
        routines: .constant(testRoutines)
    )
}
