//
//  CardView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardRouterView: View {
    var index: Int
    var routine: Routine?
    var routineCreated: Bool
    
    @Environment(RoutineEnvironment.self) var environmentContext
            
    init(
        index: Int,
        routine: Routine?
    ) {
        self.index = index
        self.routine = routine
        self.routineCreated = routine != nil
    }
    
    var body: some View {
        // card start
        ZStack {
            if routineCreated {
                RoutineCardView(
                    index: index,
                    routine: routine
                )
            } else {
                EmptyCardView(
                    index: index,
                    borderColor: Color.white
                )
            }
        }
        .animation(.easeInOut, value: environmentContext.currentPage)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CardRouterView(
        index: 1,
        routine: testRoutines[0]
    )
}
