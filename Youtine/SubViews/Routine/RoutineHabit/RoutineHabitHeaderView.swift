//
//  RoutineHabitHeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/27/25.
//

import SwiftUI

struct RoutineHabitHeaderView: View {
    var body: some View {
        // Routine title
        HStack(alignment: .center) {
            Text("Habits")
                .font(
                    .system(
                        size: 30,
                        weight: .light
                    )
                )
            Spacer()
        }
        .padding(.leading, 25)
    }
}

#Preview {
    RoutineHabitHeaderView()
}
