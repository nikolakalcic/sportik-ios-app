import SwiftUI
import Foundation

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                }
                
                Section {
                    Button("Login") {
                        login()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(!isValidForm)
                }
                
                Section {
                    Button("Forgot Password?") {
                        // Implement password reset
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var isValidForm: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    private func login() {
        Task {
            do {
                try await authViewModel.signIn(
                    email: email,
                    password: password
                )
                dismiss()
            } catch {
                showingError = true
                errorMessage = error.localizedDescription
            }
        }
    }
} 