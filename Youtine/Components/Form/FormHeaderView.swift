//
//  FormHeaderView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/19/25.
//

import SwiftUI

struct FormHeaderView: View {
    var submit: () -> Void
    var routineTitle: String?
    @Binding var selectedCellIndex: Int?
    
    // ???: State var to control confirmation dialog for delete/confirm operation
    @State private var showDeleteConfirmation = false
    @State private var showConfirmConfirmation = false
    
    @Environment(\.currentPage) var currentPage
    
    var body: some View {
        VStack {
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
                        showDeleteConfirmation = false
                        currentPage.wrappedValue = .home
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
                        // TODO: implement saveRoutine
                        showConfirmConfirmation = false
                        currentPage.wrappedValue = .home
                        submit()
                        selectedCellIndex = nil
                        
                    }
                } message: {
                    Text("Confirm")
                }
            }
            .padding(.bottom, 20)
            
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
