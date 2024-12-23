import SwiftUI
import Foundation

struct SavedActivitiesView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var savedVenues: [Venue] = []
    @State private var joinedGroups: [Venue] = []
    
    var body: some View {
        List {
            Section("Favorite Venues") {
                if savedVenues.isEmpty {
                    Text("No saved venues")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(savedVenues) { venue in
                        NavigationLink(destination: VenueDetailView(venue: venue)) {
                            VenueRowView(venue: venue)
                        }
                    }
                }
            }
            
            Section("Joined Groups") {
                if joinedGroups.isEmpty {
                    Text("No joined groups")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(joinedGroups) { group in
                        NavigationLink(destination: VenueDetailView(venue: group)) {
                            VenueRowView(venue: group)
                        }
                    }
                }
            }
        }
        .navigationTitle("Saved Activities")
        .overlay {
            if authViewModel.userType == .guest {
                GuestOverlayView(message: "Sign in to save your favorite venues and join groups")
            }
        }
    }
}

struct VenueRowView: View {
    let venue: Venue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(venue.name)
                .font(.headline)
            
            HStack {
                Image(systemName: venue.type.iconName)
                Text(venue.type.displayName)
                Spacer()
                Text(venue.location.address.city)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
} 