import Foundation
import CoreLocation

struct User: Identifiable {
    let id: UUID
    let email: String
    let userType: AuthViewModel.UserType
    var profile: UserProfile
}

struct UserProfile {
    var name: String
    var preferredLanguage: String
    var favoriteVenues: [UUID] // Venue IDs
    var joinedGroups: [UUID] // Group IDs
}

struct Location {
    let coordinate: CLLocationCoordinate2D
    let address: Address
    
    static let prague = Location(
        coordinate: CLLocationCoordinate2D(
            latitude: 50.0755,  // Prague's coordinates
            longitude: 14.4378
        ),
        address: Address(
            street: "Václavské náměstí",
            city: "Prague",
            postalCode: "110 00",
            country: "Czech Republic"
        )
    )
    
    var clLocation: CLLocation {
        CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

struct Address {
    let street: String
    let city: String
    let postalCode: String
    let country: String
    
    var formatted: String {
        "\(street), \(postalCode) \(city), \(country)"
    }
} 