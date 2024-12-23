import SwiftUI
import Foundation

struct UserSignupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var preferredLanguage = "en"
    @State private var showingError = false
    @State private var errorMessage = ""
    
    let languages = [
        ("en", "English"),
        ("cs", "Čeština")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Information") {
                    TextField("Full Name", text: $name)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                
                Section("Preferences") {
                    Picker("Language", selection: $preferredLanguage) {
                        ForEach(languages, id: \.0) { code, name in
                            Text(name).tag(code)
                        }
                    }
                }
                
                Section {
                    Button("Sign Up") {
                        signUp()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(!isValidForm)
                }
            }
            .navigationTitle("Create Account")
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
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        password.count >= 8
    }
    
    private func signUp() {
        Task {
            do {
                try await authViewModel.signUp(
                    email: email,
                    password: password,
                    userType: .regular
                )
                dismiss()
            } catch {
                showingError = true
                errorMessage = error.localizedDescription
            }
        }
    }
} 