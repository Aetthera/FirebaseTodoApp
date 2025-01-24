//
//  AddTodoView.swift
//  FirebaseTodoApp
//
//  Created by Alena Belova  on 2025-01-23.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = "" // State for the Todo title
    @State private var errorMessage: String = "" // State for error message

    var onSave: (String) -> Void // Callback to save the Todo

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Todo Title", text: $title)
                        .onChange(of: title) { newValue in
                            // Simple input validation (if not empty)
                            if newValue.isEmpty {
                                errorMessage = "Title cannot be empty."
                            } else {
                                errorMessage = ""
                            }
                        }

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Add Todo")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismissView() // Close the view
                },
                trailing: Button("Save") {
                    if !title.isEmpty {
                        onSave(title) // Pass the title back to the parent view
                        dismissView()
                    } else {
                        errorMessage = "Title cannot be empty."
                    }
                }
            )
        }
    }

    private func dismissView() {
        dismiss()
    }
}

#Preview {
    AddTodoView(onSave: { _ in
        // Placeholder action
        print("Todo saved")
    })
}
