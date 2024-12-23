import SwiftUI
import Foundation

struct ClubSignupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var clubName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var description = ""
    @State private var sports: [Sport] = []
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Club Information") {
                    TextField("Club Name", text: $clubName)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                
                Section("About") {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section {
                    Button("Register Club") {
                        registerClub()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(!isValidForm)
                }
            }
            .navigationTitle("Club Registration")
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
        !clubName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        password.count >= 8
    }
    
    private func registerClub() {
        Task {
            do {
                try await authViewModel.signUp(
                    email: email,
                    password: password,
                    userType: .club
                )
                dismiss()
            } catch {
                showingError = true
                errorMessage = error.localizedDescription
            }
        }
    }
} 