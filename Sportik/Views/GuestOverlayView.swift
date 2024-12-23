import SwiftUI

struct GuestOverlayView: View {
    let message: String
    
    init(message: String = "Please sign in to access this feature") {
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Sign In Required")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(action: {
                // Add your sign in action here
            }) {
                Text("Sign In")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    GuestOverlayView(message: "Sign in to view your saved content")
} 