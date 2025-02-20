//
//  FormHeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct FormHeaderView: View {
    @Binding var hasChanges: Bool
    @Binding var selectedCellIndex: Int?
    var routineTitle: String?
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.handleFormSubmit) var handleFormSubmit
    
    var body: some View {
        VStack {
            FormToolbarView(
                hasChanges: $hasChanges,
                selectedCellIndex: $selectedCellIndex
            )
            
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

//#Preview {
//    FormHeaderView(
//        submit: () -> Void, selectedCellIndex: .constant(0)
//    )
//}
