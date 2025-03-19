//
//  ExpandedDetailToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/22/25.
//

import SwiftUI

struct RoutineDetailToolbarView: View {
    @State var showDeleteConfirmation: Bool = false
    
    @Environment(RoutineEnvironment.self) var environmentContext
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
                Button("Delete Routine", role: .destructive) {
                    // MARK: RUN DELETE FUNCTION TO UPDATE SAVED ROUTINES
                    handleDeleteRoutine()
                    
                    // MARK: NAVIGATE TO .home
                    environmentContext.updatePage(to: .home)
                    
                    // MARK: STOP SHOWING DELETE DIALOG
                    showDeleteConfirmation = false
                }
            } message: {
                Text("Confirm")
            }
            
            Rectangle()
                .frame(width: 0.2, height: 25)
                .padding(.top, 5)
            
            Button {
                // MARK: NAVIGATE TO .editRoutine
                environmentContext.updatePage(to: .editRoutine)
            } label: {
                Image(systemName: "pencil")
            }
        }
    }
}

#Preview {
    RoutineDetailToolbarView()
}
