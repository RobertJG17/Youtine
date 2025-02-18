//
//  FormHeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct FormHeaderView: View {
    var routineTitle: String?
    @Binding var selectedCellIndex: Int?
    var hasChanges: Bool
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.handleFormSubmit) var handleFormSubmit
    
    var body: some View {
        VStack {
            FormToolbarView(
                selectedCellIndex: $selectedCellIndex,
                hasChanges: hasChanges
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
