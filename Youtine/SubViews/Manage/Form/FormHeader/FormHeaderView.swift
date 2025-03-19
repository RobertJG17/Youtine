//
//  FormHeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct FormHeaderView: View {
    @Binding var hasChanges: Bool
    var routineTitle: String?
    
    var body: some View {
        VStack {
            FormToolbarView(hasChanges: $hasChanges)
            
            Spacer()
            
            HStack {
                if let title = routineTitle {
                    Text(title)
                        .font(.system(size: 30, weight: .light))
                }
            }
        }
    }
}

#Preview {
    FormHeaderView(
        hasChanges: .constant(false),
        routineTitle: getRoutineTitle(index: 0)
    )
}
