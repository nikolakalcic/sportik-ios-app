import SwiftUI
import CoreLocation
import Foundation

struct SportVenuesView: View {
    let sport: Sport
    @State private var searchText = ""
    @State private var selectedVenueType: VenueType?
    @State private var sortOrder = SortOrder.distance
    @State private var userLocation: CLLocation = Location.prague.clLocation // Default to Prague
    
    enum SortOrder {
        case distance
        case name
        case rating
    }
    
    var body: some View {
        List {
            // Filter Section
            Section {
                HStack {
                    ForEach([VenueType.club, .coach, .group], id: \.self) { type in
                        FilterChip(
                            title: type.displayName,
                            isSelected: selectedVenueType == type,
                            action: {
                                if selectedVenueType == type {
                                    selectedVenueType = nil
                                } else {
                                    selectedVenueType = type
                                }
                            }
                        )
                    }
                }
                .padding(.vertical, 5)
            }
            
            // Venues List
            Section {
                ForEach(filteredVenues) { venue in
                    NavigationLink(destination: VenueDetailView(venue: venue)) {
                        VenueListRow(venue: venue)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search venues")
        .navigationTitle(sport.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Picker("Sort By", selection: $sortOrder) {
                        Text("Distance").tag(SortOrder.distance)
                        Text("Name").tag(SortOrder.name)
                        Text("Rating").tag(SortOrder.rating)
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
        }
    }
    
    private var filteredVenues: [Venue] {
        var venues = sport.venues
        
        // Apply type filter
        if let type = selectedVenueType {
            venues = venues.filter { $0.type == type }
        }
        
        // Apply search filter
        if !searchText.isEmpty {
            venues = venues.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Apply sorting
        switch sortOrder {
        case .distance:
            venues.sort { venue1, venue2 in
                let distance1 = venue1.location.clLocation.distance(from: userLocation)
                let distance2 = venue2.location.clLocation.distance(from: userLocation)
                return distance1 < distance2
            }
        case .name:
            venues.sort { $0.name < $1.name }
        case .rating:
            venues.sort { $0.name < $1.name } // Will update when we add ratings
        }
        
        return venues
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct VenueListRow: View {
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