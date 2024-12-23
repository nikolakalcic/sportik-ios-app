import Foundation

public enum VenueType: String, CaseIterable {
    case club
    case coach
    case group
    
    public var displayName: String {
        switch self {
        case .club: return "Sports Club"
        case .coach: return "Personal Coach"
        case .group: return "Sports Group"
        }
    }
    
    public var iconName: String {
        switch self {
        case .club: return "building.2"
        case .coach: return "person"
        case .group: return "person.3"
        }
    }
} 