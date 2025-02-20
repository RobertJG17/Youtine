//
//  FormToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/22/25.
//

import SwiftUI

struct FormToolbarView: View {
    @Binding var hasChanges: Bool
    @Binding var selectedCellIndex: Int?
    
    @Environment(\.currentPage) var currentPage
    @Environment(\.handleFormSubmit) var handleFormSubmit
    
    // ???: State var to control confirmation dialog for delete/confirm operation
    @State private var showDeleteConfirmation = false
    @State private var showConfirmConfirmation = false
    
    @State private var deleteButtonTitle: String = "Delete"
    @State private var saveButtonTitle: String = "Create Routine"
    
    func handleNav() {
        if currentPage.wrappedValue == .editRoutine {
            // MARK: NAVIGATE TO .routine
            currentPage.wrappedValue = .routine
        } else {
            // MARK: NAVIGATE TO .home
            currentPage.wrappedValue = .home
        }
    }
    
    var body: some View {
        HStack {
            Button {
                if hasChanges {
                    showDeleteConfirmation = true
                } else {
                    handleNav()
                }
                
            } label: {
                Text("Cancel")
                    .fontWeight(.light)
                    .foregroundStyle(Color.red)
            }
            .confirmationDialog(
                "delete-dialog",
                isPresented: $showDeleteConfirmation
            ) {
                
                Button(deleteButtonTitle, role: .destructive) {
                    // MARK: STOP SHOWING DELETE DIALOG
                    showDeleteConfirmation = false
                    
                    // MARK: Conditional Navigation based on currentPage state
                    handleNav()
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
                Button(saveButtonTitle) {
                    // MARK: RUN SUBMIT FUNCTION TO UPDATE SAVED ROUTINES
                    handleFormSubmit()
                    
                    // MARK: Conditional Navigation based on currentPage state
                    handleNav()
                    
                    // MARK: STOP SHOWING CONFIRMATION DIALOG
                    showConfirmConfirmation = false
                }
            } message: {
                Text("Confirm")
            }
        }
        .padding(.bottom, 20)
        .onAppear {
            deleteButtonTitle = currentPage.wrappedValue == .editRoutine
            ? "Discard Changes" : "Delete"
            
            saveButtonTitle = currentPage.wrappedValue == .editRoutine
            ? "Save Changes" : "Create Routine"
        }
        .onChange(of: hasChanges) { _, newValue in
            print("Has changes?: ", hasChanges)
        }
    }
}

#Preview {
    FormToolbarView(
        hasChanges: .constant(false),
        selectedCellIndex: .constant(0)
    )
}
