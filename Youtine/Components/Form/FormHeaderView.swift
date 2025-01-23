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
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.handleFormSubmit) var handleFormSubmit
    
    var body: some View {
        VStack {
            FormToolbarView(selectedCellIndex: $selectedCellIndex)
            
            Spacer()
            
            HStack {
                if routineTitle != nil {
                    Text(routineTitle!)
                        .font(.system(size: 35, weight: .light))
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
