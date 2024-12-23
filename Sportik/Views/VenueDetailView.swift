import SwiftUI
import MapKit
import Foundation

struct VenueDetailView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    let venue: Venue
    
    @State private var showingChatSheet = false
    @State private var isFavorite = false
    @State private var cameraPosition: MapCameraPosition
    
    init(venue: Venue) {
        self.venue = venue
        let position = MapCameraPosition.region(MKCoordinateRegion(
            center: venue.location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
        _cameraPosition = State(initialValue: position)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Map View
                Map(position: $cameraPosition) {
                    Marker(venue.name, coordinate: venue.location.coordinate)
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Venue Info
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(venue.name)
                            .font(.title)
                            .bold()
                        Spacer()
                        Button {
                            toggleFavorite()
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                        }
                    }
                    
                    Text(venue.type.displayName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    // Contact Info
                    if let phone = venue.contact.phone {
                        ContactRow(icon: "phone", text: phone)
                    }
                    if let email = venue.contact.email {
                        ContactRow(icon: "envelope", text: email)
                    }
                    ContactRow(icon: "location", text: venue.location.address.formatted)
                    
                    // Languages
                    HStack {
                        Image(systemName: "message")
                        Text("Languages: \(venue.contact.languages.joined(separator: ", "))")
                    }
                    .foregroundColor(.secondary)
                }
                .padding()
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button {
                        showingChatSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Chat with \(venue.type == .coach ? "Coach" : "Venue")")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    if venue.type == .group {
                        Button {
                            // Join group logic
                        } label: {
                            HStack {
                                Image(systemName: "person.2.fill")
                                Text("Join Group")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingChatSheet) {
            if authViewModel.userType == .guest {
                GuestOverlayView(message: "Sign in to chat with venues and coaches")
            } else {
                ChatView(venue: venue)
            }
        }
    }
    
    private func toggleFavorite() {
        if authViewModel.userType == .guest {
            // Show sign in prompt
            return
        }
        isFavorite.toggle()
        // Update favorites in backend
    }
}

struct ContactRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(text)
        }
        .foregroundColor(.secondary)
    }
}

struct ChatView: View {
    let venue: Venue
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    
    var body: some View {
        VStack {
            Text("Chat with \(venue.name)")
                .font(.headline)
                .padding()
            
            Spacer()
            
            Text("Chat functionality coming soon...")
                .foregroundColor(.secondary)
            
            Spacer()
            
            HStack {
                TextField("Message", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // Send message
                } label: {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    let timestamp: Date
} 