//
//  ExpandedDetailToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/22/25.
//

import SwiftUI

struct ExpandedDetailToolbarView: View {
    @Binding var routine: Youtine?
    @Binding var selectedCellIndex: Int?
    
    @State var showDeleteConfirmation: Bool = false
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.handleDeleteRoutine) var handleDeleteRoutine
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                showDeleteConfirmation = true
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(Color.red)
            }
            .confirmationDialog(
                "expanded-delete-dialog",
                isPresented: $showDeleteConfirmation
            ) {
                Button("Delete", role: .destructive) {
                    /// MARK: STOP SHOWING DELETE DIALOG
                    showDeleteConfirmation = false
                    
                    /// MARK: RUN DELETE FUNCTION TO UPDATE SAVED ROUTINES
                    handleDeleteRoutine()
                    
                    /// MARK: NAVIGATE TO .home
                    currentPage.wrappedValue = .home
                }
            } message: {
                Text("Delete Routine")
            }
            
            Button {
                /// MARK: NAVIGATE TO .editRoutine
                currentPage.wrappedValue = .editRoutine
            } label: {
                Image(systemName: "pencil")
            }
        }
    }
}

#Preview {
    ExpandedDetailToolbarView(routine: .constant(testRoutines[0]), selectedCellIndex: .constant(0))
}
