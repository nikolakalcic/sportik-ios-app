
# Sportik iOS App Documentation

## Project Overview
Sportik is an iOS application built with SwiftUI targeting iOS 17.0 and later. The app is designed to handle sports activities and venue management.

## Technical Specifications
- **Development Environment**
  - Xcode 16.2
  - Swift 5.0
  - iOS Deployment Target: 17.0
  - SwiftUI Framework
  - MVVM Architecture

## Project Structure
```
Sportik/
├── Assets.xcassets/          # App assets and images
├── Models/                   # Data models
│   ├── Sport.swift
│   ├── User.swift
│   └── VenueType.swift
├── ViewModels/              # Business logic
│   ├── AuthViewModel.swift
│   └── SportViewModel.swift
├── Views/                   # UI Components
│   ├── ContentView.swift
│   ├── LandingView.swift
│   ├── LoginView.swift
│   ├── VenueDetailView.swift
│   ├── SportVenuesView.swift
│   ├── SavedActivitiesView.swift
│   ├── SettingsView.swift
│   └── [Other Views]
├── Preview Content/         # Preview assets
└── SportikApp.swift         # App entry point
```

## Key Features
1. User Authentication
   - Login functionality
   - User registration
   - Club signup

2. Venue Management
   - Venue browsing
   - Venue details
   - Favorite venues

3. Sports Activities
   - Sport search
   - Activity tracking
   - Group activities

## Configuration
- Bundle Identifier: `KALCHA.Sportik`
- Development Team: `YLVSW7HZ8C`
- Supported Devices: iPhone and iPad (Universal)
- Supported Orientations: All orientations

## Testing
- Unit Tests: `SportikTests`
- UI Tests: `SportikUITests`

## Build Configurations
- Debug and Release schemes
- Automatic code signing
- Asset catalogs for app icon and accent colors

## Version Control
- Git repository
- `.gitignore` configured for Xcode projects
- Key files tracked:
  - `project.pbxproj`
  - Shared Xcode schemes
  - Workspace settings

