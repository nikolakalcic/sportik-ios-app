import Foundation
import SwiftUI

class SportViewModel: ObservableObject {
    @Published var sports: [Sport]
    @Published var selectedSport: Sport?
    @Published var isLoading = false
    @Published var error: Error?
    
    init(sports: [Sport] = Sport.defaultSports) {
        self.sports = sports
        
        // Add sample venues to each sport for testing
        self.sports = sports.map { sport in
            Sport(
                id: sport.id,
                name: sport.name,
                icon: sport.icon,
                venues: Venue.sampleVenues
            )
        }
    }
    
    func refreshSports() async {
        // Here we'll add API call to fetch sports and venues
        isLoading = true
        defer { isLoading = false }
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // For now, just reset to default sports
        sports = Sport.defaultSports
    }
} 