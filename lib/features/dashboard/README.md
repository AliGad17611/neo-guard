# 🌍 NEO Dashboard - Near Earth Objects Tracker

A comprehensive dashboard for tracking Near Earth Objects (NEOs) using NASA's official NEO Web Service API.

## 📋 Features

### ✨ Core Functionality
- **Real-time NEO Data**: Fetches live data from NASA's NEO API
- **Statistics Cards**: Quick overview of total NEOs, hazardous asteroids, largest, and fastest objects
- **Detailed NEO List**: Scrollable list of all Near Earth Objects with key information
- **Pull-to-Refresh**: Easy data refresh with pull-down gesture
- **Detailed View**: Bottom sheet with comprehensive information about each asteroid
- **External Links**: Direct links to NASA JPL database for more information

### 🎨 UI/UX Features
- **Beautiful Gradient Design**: Space-themed UI with smooth gradients
- **Hazard Indicators**: Visual warnings for potentially hazardous asteroids
- **Responsive Cards**: Touch-friendly card design for easy browsing
- **Loading States**: Elegant loading indicators during data fetch
- **Error Handling**: User-friendly error messages with retry option
- **Date Display**: Current date and data source information

### 📊 Data Displayed
For each NEO, the dashboard shows:
- **Name and ID**: Official asteroid designation
- **Size**: Estimated diameter in meters
- **Velocity**: Relative velocity in km/h
- **Miss Distance**: How close the asteroid passes Earth
- **Hazard Status**: Whether the asteroid is potentially hazardous
- **Close Approach Data**: Date and time of closest approach
- **Physical Properties**: Absolute magnitude and diameter ranges

## 🏗️ Architecture

This feature follows **Clean Architecture** principles with **Cubit** state management:

```
dashboard/
├── domain/                      # Business Logic Layer
│   ├── entities/
│   │   ├── neo_entity.dart              # NEO entity with all properties
│   │   └── neo_feed_entity.dart         # Feed entity with utilities
│   ├── repositories/
│   │   └── neo_repository.dart          # Repository interface
│   └── usecases/
│       └── get_neo_feed.dart            # Use case for fetching NEO data
│
├── data/                        # Data Layer
│   ├── models/
│   │   ├── neo_model.dart               # NEO data model
│   │   └── neo_feed_model.dart          # Feed data model
│   ├── datasources/
│   │   └── neo_remote_data_source.dart  # API client
│   └── repositories/
│       └── neo_repository_impl.dart     # Repository implementation
│
└── presentation/                # Presentation Layer
    ├── cubit/
    │   ├── dashboard_cubit.dart         # State management
    │   └── dashboard_state.dart         # State definitions
    ├── pages/
    │   └── dashboard_page.dart          # Main dashboard page
    └── widgets/
        ├── dashboard_header.dart        # Header with date
        ├── neo_stats_cards.dart         # Statistics cards
        ├── neo_list_view.dart           # List of NEOs
        ├── neo_card.dart                # Individual NEO card
        ├── neo_detail_bottom_sheet.dart # Detailed view
        └── dashboard_error_view.dart    # Error state UI
```

## 🔌 API Integration

### Endpoint
```
https://api.nasa.gov/neo/rest/v1/feed
```

### Parameters
- `start_date`: Start date (YYYY-MM-DD)
- `end_date`: End date (YYYY-MM-DD, max 7 days from start)
- `api_key`: NASA API key (currently using DEMO_KEY)

### Response Structure
The API returns a JSON object containing:
- `element_count`: Total number of NEOs
- `near_earth_objects`: Object with dates as keys and arrays of NEO objects as values
- Each NEO includes:
  - Basic information (id, name, NASA JPL URL)
  - Physical properties (magnitude, diameter estimates)
  - Hazard classification
  - Close approach data (date, velocity, miss distance)

## 🎯 State Management

The dashboard uses **Cubit** for state management with the following states:

1. **DashboardInitial**: Initial state before any data is loaded
2. **DashboardLoading**: Data is being fetched from the API
3. **DashboardLoaded**: Data successfully loaded and ready to display
4. **DashboardError**: Error occurred during data fetch

## 🚀 Usage

### Navigation
Navigate to the dashboard from the home page or use:
```dart
Navigator.pushNamed(context, Routes.dashboard);
```

### Customization
To use your own NASA API key:
1. Get a free API key from [NASA API Portal](https://api.nasa.gov/)
2. Update the `apiKey` in `lib/features/dashboard/data/datasources/neo_remote_data_source.dart`

## 📱 User Journey

1. User taps "NEO Dashboard" on home page
2. Dashboard loads today's NEO data automatically
3. Statistics cards show quick overview
4. User scrolls through list of NEOs
5. User taps on any NEO for detailed information
6. Bottom sheet appears with comprehensive data
7. User can open NASA JPL link for more details
8. Pull down to refresh data

## 🎨 Design System

### Color Scheme
- **Background**: Dark gradient (space theme)
- **Cards**: Semi-transparent with gradients
- **Hazard Indicator**: Red gradient for hazardous asteroids
- **Normal NEOs**: Blue/Purple gradient
- **Accent Color**: Cyan for interactive elements

### Typography
- **Headers**: Bold, white text
- **Body**: Regular weight, slightly transparent white
- **Labels**: Small, more transparent for secondary info

## 🔧 Dependencies

- `http`: HTTP client for API calls
- `dartz`: Functional programming (Either for error handling)
- `equatable`: Value equality for entities
- `flutter_bloc`: State management with Cubit
- `intl`: Date formatting and number formatting
- `url_launcher`: Opening external NASA JPL links

## 📈 Future Enhancements

Potential improvements:
- [ ] Filter NEOs by hazard status
- [ ] Sort options (by size, velocity, distance)
- [ ] Date range picker for custom queries
- [ ] Favorites/bookmarks for specific NEOs
- [ ] Notifications for approaching asteroids
- [ ] 3D visualization of asteroid orbits
- [ ] Historical data and trends
- [ ] Share NEO information
- [ ] Offline caching of recent data

## 🐛 Error Handling

The app handles various error scenarios:
- **Network errors**: Shows friendly message with retry option
- **API rate limits**: Informs user to try again later
- **Invalid date ranges**: Validates date range (max 7 days)
- **Empty results**: Shows appropriate empty state

## 📊 Data Flow

```
User Action
    ↓
DashboardCubit (loadTodayData)
    ↓
GetNeoFeed UseCase
    ↓
NeoRepository
    ↓
NeoRemoteDataSource
    ↓
NASA API
    ↓
NeoFeedModel.fromJson()
    ↓
Either<Error, NeoFeedEntity>
    ↓
DashboardState (Loaded/Error)
    ↓
UI Update
```

## 🌟 Best Practices

- ✅ Clean Architecture separation
- ✅ Dependency Injection with GetIt
- ✅ Immutable state objects
- ✅ Proper error handling
- ✅ Type-safe models
- ✅ Responsive UI design
- ✅ Pull-to-refresh pattern
- ✅ Loading and error states

## 📚 API Documentation

Full API documentation available at:
- [NASA NEO Web Service](https://api.nasa.gov/)
- [NEO API Documentation](https://api.nasa.gov/neo/)

---

**Built with ❤️ using Flutter and NASA's Open APIs**

