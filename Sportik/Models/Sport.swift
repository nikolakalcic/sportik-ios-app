import Foundation
import CoreLocation

struct Sport: Identifiable {
    let id: UUID
    let name: String
    let icon: String // System icon name
    let venues: [Venue]
    
    init(id: UUID = UUID(), name: String, icon: String, venues: [Venue] = []) {
        self.id = id
        self.name = name
        self.icon = icon
        self.venues = venues
    }
    
    static let defaultSports = [
        Sport(name: "Football", icon: "football.fill", venues: []),
        Sport(name: "Basketball", icon: "basketball.fill", venues: []),
        Sport(name: "Tennis", icon: "figure.tennis", venues: []),
        Sport(name: "Swimming", icon: "figure.pool.swim", venues: []),
        Sport(name: "Running", icon: "figure.run", venues: [])
    ]
}

struct Venue: Identifiable {
    let id: UUID
    let name: String
    let type: VenueType
    let location: Location
    let contact: Contact
    
    init(
        id: UUID = UUID(),
        name: String,
        type: VenueType,
        location: Location = Location.prague,
        contact: Contact
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.location = location
        self.contact = contact
    }
    
    static var sampleVenues: [Venue] {
        [
            Venue(
                name: "Prague Sports Center",
                type: .club,
                contact: Contact(
                    name: "John Doe",
                    phone: "+420 123 456 789",
                    email: "info@pragesports.cz",
                    languages: ["Czech", "English"]
                )
            ),
            Venue(
                name: "Coach Mike",
                type: .coach,
                contact: Contact(
                    name: "Mike Smith",
                    phone: "+420 987 654 321",
                    email: "mike@coach.cz",
                    languages: ["English"]
                )
            ),
            Venue(
                name: "Running Group Prague",
                type: .group,
                contact: Contact(
                    name: "Sarah Johnson",
                    phone: nil,
                    email: "run@prague.cz",
                    languages: ["Czech", "English", "German"]
                )
            )
        ]
    }
}

struct Contact {
    let name: String
    let phone: String?
    let email: String?
    let languages: [String]
    
    init(
        name: String,
        phone: String? = nil,
        email: String? = nil,
        languages: [String] = ["English"]
    ) {
        self.name = name
        self.phone = phone
        self.email = email
        self.languages = languages
    }
} 