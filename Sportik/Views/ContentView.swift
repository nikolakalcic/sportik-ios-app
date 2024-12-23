import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var sportViewModel = SportViewModel()
    @State private var selectedTab = 0
    @State private var searchRadius: Double = 5.0
    @State private var selectedLanguage = "en"
    
    var body: some View {
        Group {
            if !authViewModel.isAuthenticated {
                LandingView()
                    .environmentObject(authViewModel)
            } else {
                TabView(selection: $selectedTab) {
                    // Search/Browse View
                    NavigationView {
                        SportSearchView(searchRadius: $searchRadius)
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(0)
                    
                    // Favorites/Saved
                    NavigationView {
                        SavedActivitiesView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Saved")
                    }
                    .tag(1)
                    
                    // Profile/Settings
                    NavigationView {
                        SettingsView(selectedLanguage: $selectedLanguage)
                    }
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2)
                }
            }
        }
        .environmentObject(authViewModel)
        .environmentObject(sportViewModel)
    }
} 