import SwiftUI
import CoreLocation

struct SportSearchView: View {
    @EnvironmentObject private var sportViewModel: SportViewModel
    @Binding var searchRadius: Double
    @State private var searchText = ""
    
    var body: some View {
        List {
            Section {
                // Radius selector
                HStack {
                    Text("Search radius: \(Int(searchRadius))km")
                    Slider(value: $searchRadius, in: 1...50)
                }
                .padding(.vertical, 4)
            }
            
            // Sports list
            Section {
                if sportViewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else if filteredSports.isEmpty {
                    Text("No sports found")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    ForEach(filteredSports) { sport in
                        NavigationLink(destination: SportVenuesView(sport: sport)) {
                            SportRowView(sport: sport)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search sports")
        .navigationTitle("Find Sports")
        .refreshable {
            await sportViewModel.refreshSports()
        }
        .task {
            if sportViewModel.sports.isEmpty {
                await sportViewModel.refreshSports()
            }
        }
    }
    
    private var filteredSports: [Sport] {
        if searchText.isEmpty {
            return sportViewModel.sports
        }
        return sportViewModel.sports.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

struct SportRowView: View {
    let sport: Sport
    
    var body: some View {
        HStack {
            Image(systemName: sport.icon)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(sport.name)
                    .font(.headline)
                
                Text("\(sport.venues.count) venues nearby")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
} 