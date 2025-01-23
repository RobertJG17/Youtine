//
//  FormToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/22/25.
//

import SwiftUI

struct FormToolbarView: View {
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.handleFormSubmit) var handleFormSubmit
    
    // ???: State var to control confirmation dialog for delete/confirm operation
    @State private var showDeleteConfirmation = false
    @State private var showConfirmConfirmation = false
    
    var body: some View {
        HStack {
            
            Button {
                showDeleteConfirmation = true
            } label: {
                Text("Cancel")
                    .fontWeight(.light)
                    .foregroundStyle(Color.red)
            }
            .confirmationDialog(
                "delete-dialog",
                isPresented: $showDeleteConfirmation
            ) {
                Button("Delete", role: .destructive) {
                    /// MARK: STOP SHOWING DELETE DIALOG
                    showDeleteConfirmation = false
                    
                    /// MARK: NAVIGATE TO .home
                    currentPage.wrappedValue = .home
                    
                    /// MARK: SET selecteCellIndex nil
                    selectedCellIndex = nil
                }
            } message: {
                Text("Confirm")
            }
            
            Spacer()
            
            Button {
                showConfirmConfirmation = true
            } label: {
                Text("Done")
            }
            .confirmationDialog(
                "confirm-dialog",
                isPresented: $showConfirmConfirmation
            ) {
                Button("Create Routine") {
                    /// MARK: NAVIGATE TO .home
                    currentPage.wrappedValue = .home
                    
                    /// MARK: STOP SHOWING CONFIRMATION DIALOG
                    showConfirmConfirmation = false
                    
                    /// MARK: RUN SUBMIT FUNCTION TO UPDATE SAVED ROUTINES
                    handleFormSubmit()
                    
                    /// MARK: SET selecteCellIndex nil
                    selectedCellIndex = nil
                    
                }
            } message: {
                Text("Confirm")
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    FormToolbarView(selectedCellIndex: .constant(0))
}
