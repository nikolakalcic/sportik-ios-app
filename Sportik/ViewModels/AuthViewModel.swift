import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userType: UserType?
    @Published var currentUser: User?
    
    enum UserType {
        case guest
        case regular
        case club
    }
    
    func continueAsGuest() {
        userType = .guest
        isAuthenticated = true
    }
    
    func signIn(email: String, password: String) async throws {
        // Implement sign in logic
    }
    
    func signUp(email: String, password: String, userType: UserType) async throws {
        // Implement sign up logic
    }
    
    func signOut() {
        isAuthenticated = false
        userType = nil
        currentUser = nil
    }
} 