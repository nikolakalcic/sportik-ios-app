import SwiftUI
import Foundation

struct SettingsView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @Binding var selectedLanguage: String
    @State private var showingLogoutAlert = false
    
    let languages = [
        ("en", "English"),
        ("cs", "Čeština")
    ]
    
    var body: some View {
        List {
            if let userType = authViewModel.userType, userType != .guest {
                Section("Account") {
                    if let email = authViewModel.currentUser?.email {
                        LabeledContent("Email", value: email)
                    }
                    
                    Button("Sign Out", role: .destructive) {
                        showingLogoutAlert = true
                    }
                }
            }
            
            Section("Preferences") {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.0) { code, name in
                        Text(name).tag(code)
                    }
                }
                
                NavigationLink("Notifications") {
                    NotificationSettingsView()
                }
            }
            
            Section("About") {
                NavigationLink("Privacy Policy") {
                    PrivacyPolicyView()
                }
                
                NavigationLink("Terms of Service") {
                    TermsOfServiceView()
                }
                
                LabeledContent("Version", value: Bundle.main.appVersion)
            }
        }
        .navigationTitle("Settings")
        .alert("Sign Out", isPresented: $showingLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Sign Out", role: .destructive) {
                authViewModel.signOut()
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }
}

struct NotificationSettingsView: View {
    @AppStorage("pushNotificationsEnabled") private var pushNotificationsEnabled = true
    @AppStorage("emailNotificationsEnabled") private var emailNotificationsEnabled = true
    
    var body: some View {
        List {
            Section {
                Toggle("Push Notifications", isOn: $pushNotificationsEnabled)
                Toggle("Email Notifications", isOn: $emailNotificationsEnabled)
            }
        }
        .navigationTitle("Notifications")
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("Privacy Policy content goes here...")
                .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            Text("Terms of Service content goes here...")
                .padding()
        }
        .navigationTitle("Terms of Service")
    }
}

private extension Bundle {
    var appVersion: String {
        "\(infoDictionary?["CFBundleShortVersionString"] as? String ?? "") (\(infoDictionary?["CFBundleVersion"] as? String ?? ""))"
    }
} 