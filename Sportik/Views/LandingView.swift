import SwiftUI

struct LandingView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var showingClubSignup = false
    @State private var showingUserSignup = false
    @State private var showingLogin = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                // Logo and Welcome Text
                Image(systemName: "figure.run.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("Welcome to Sportik")
                    .font(.largeTitle)
                    .bold()
                
                Text("Connect with sports clubs and activities near you")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                // Main Action Buttons
                VStack(spacing: 16) {
                    Button(action: { showingClubSignup = true }) {
                        Text("Register Your Club")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { showingUserSignup = true }) {
                        Text("Sign Up as User")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { showingLogin = true }) {
                        Text("Login")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)
                
                // Explore Without Account
                Button(action: { 
                    authViewModel.continueAsGuest()
                }) {
                    Text("Explore Without Account")
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 30)
            }
            .sheet(isPresented: $showingClubSignup) {
                ClubSignupView()
            }
            .sheet(isPresented: $showingUserSignup) {
                UserSignupView()
            }
            .sheet(isPresented: $showingLogin) {
                LoginView()
            }
        }
    }
} 