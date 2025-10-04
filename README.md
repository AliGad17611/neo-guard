# 🌌 NeoGuard

[![Flutter](https://img.shields.io/badge/Flutter-3.9.0-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.0-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**NeoGuard** is a comprehensive Flutter application that educates users about Near-Earth Objects (NEOs) and provides real-time asteroid tracking, impact simulation, interactive 3D visualization, and an engaging space defense game. Built with NASA's official APIs, NeoGuard combines education with entertainment to raise awareness about planetary defense.

---

## 📱 Features

### 🎯 Core Features

#### 1. **NEO Dashboard** 📊
- Real-time tracking of Near-Earth Objects using NASA's NeoWs API
- Interactive timeline view of asteroid approaches
- Detailed information about each NEO (size, velocity, distance, hazard status)
- Statistics cards showing total NEOs, hazardous asteroids, and close approaches

#### 2. **Asteroid Impact Calculator** 💥
- Physics-based simulation of asteroid impact effects
- Calculates energy release, crater dimensions, seismic effects
- Tsunami wave generation and propagation analysis
- Visual severity indicators and warnings
- Adjustable parameters: diameter, velocity, impact angle, density

#### 3. **NASA Eyes on Asteroids** 🔭
- Embedded NASA's Eyes on Asteroids 3D visualization
- Interactive exploration of asteroid trajectories
- Real-time orbital data visualization
- WebView integration with NASA's official tools

#### 4. **Education Center** 📚
- Comprehensive definitions of astronomical terms
- Educational videos about asteroids and planetary defense
- Quiz system with multiple difficulty levels (Easy, Medium, Hard)
- Interactive learning resources

#### 5. **Meteor Madness Game** 🎮
- Action-packed space defense game built with Flame engine
- Three difficulty levels (Easy, Normal, Hard)
- Multiple weapon systems (Normal Shot, Triple Shot, Laser)
- Progressive wave system with increasing difficulty
- Shield mechanics and upgrade system
- High score tracking

---

## 🏗️ Architecture

NeoGuard follows **Clean Architecture** principles with a feature-based modular structure, ensuring separation of concerns, testability, and maintainability.

### Architecture Overview

```mermaid
graph TB
    subgraph "Presentation Layer"
        UI[UI/Widgets]
        Pages[Pages]
        Cubit[Cubit/BLoC]
    end
    
    subgraph "Domain Layer"
        UseCase[Use Cases]
        Entity[Entities]
        RepoInterface[Repository Interfaces]
    end
    
    subgraph "Data Layer"
        RepoImpl[Repository Implementations]
        DataSource[Data Sources]
        Models[Models]
    end
    
    subgraph "External"
        API[NASA API]
        LocalStorage[Local Storage]
    end
    
    UI --> Cubit
    Pages --> Cubit
    Cubit --> UseCase
    UseCase --> RepoInterface
    RepoImpl -.implements.-> RepoInterface
    RepoImpl --> DataSource
    DataSource --> API
    DataSource --> LocalStorage
    Models --> Entity
    
    style UI fill:#e1f5ff
    style Cubit fill:#b3e5fc
    style UseCase fill:#81d4fa
    style RepoImpl fill:#4fc3f7
    style DataSource fill:#29b6f6
```

### Feature Structure

Each feature follows a consistent three-layer architecture:

```mermaid
graph LR
    subgraph "Feature Module"
        subgraph "presentation"
            P1[Pages]
            P2[Widgets]
            P3[Cubit/State]
        end
        
        subgraph "domain"
            D1[Entities]
            D2[Repositories]
            D3[Use Cases]
        end
        
        subgraph "data"
            DA1[Models]
            DA2[Data Sources]
            DA3[Repository Impl]
        end
    end
    
    P3 --> D3
    D3 --> D2
    DA3 -.implements.-> D2
    DA3 --> DA2
    DA1 --> D1
    
    style P1 fill:#e8f5e9
    style P2 fill:#e8f5e9
    style P3 fill:#c8e6c9
    style D1 fill:#fff9c4
    style D2 fill:#fff59d
    style D3 fill:#fff176
    style DA1 fill:#ffccbc
    style DA2 fill:#ffab91
    style DA3 fill:#ff8a65
```

### Directory Structure

```
lib/
├── core/                          # Core functionality
│   ├── di/                        # Dependency Injection (GetIt)
│   │   └── service_locator.dart
│   ├── network/                   # Network clients
│   │   └── dio_client.dart
│   ├── router/                    # Navigation & routing
│   │   ├── app_routers.dart
│   │   └── routes.dart
│   ├── storage/                   # Local storage utilities
│   │   └── cache_helper.dart
│   └── theme/                     # App theming
│       └── app_colors.dart
│
├── features/                      # Feature modules
│   ├── home/                      # Landing page
│   │   └── presentation/
│   │
│   ├── dashboard/                 # NEO Dashboard
│   │   ├── data/
│   │   │   ├── datasources/       # NASA API integration
│   │   │   ├── models/            # Data models
│   │   │   └── repositories/      # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/          # Business entities
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   └── usecases/          # Business logic
│   │   └── presentation/
│   │       ├── cubit/             # State management
│   │       ├── pages/             # Screen UI
│   │       └── widgets/           # Reusable components
│   │
│   ├── asteroid_impact/           # Impact Calculator
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── nasa_eyes/                 # NASA Eyes WebView
│   │   └── presentation/
│   │
│   ├── meteor_madness/            # Game
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── game/              # Flame game engine
│   │       │   └── components/    # Game components
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── education/                 # Learning resources
│   │   └── presentation/
│   │
│   └── quiz/                      # Quiz system
│       ├── data/
│       └── presentation/
│
├── main.dart                      # App entry point
└── neo_guard_app.dart             # Root app widget
```

---

## 📊 Data Flow

### NEO Dashboard Data Flow

This diagram illustrates the complete data flow for fetching and displaying Near-Earth Object data:

```mermaid
sequenceDiagram
    participant UI as Dashboard Page
    participant C as DashboardCubit
    participant UC as GetNeoFeed UseCase
    participant R as NeoRepository
    participant DS as NeoRemoteDataSource
    participant API as NASA API
    
    UI->>C: Load NEO Data
    activate C
    C->>C: emit(Loading)
    C->>UC: call(startDate, endDate)
    activate UC
    UC->>R: getNeoFeed(startDate, endDate)
    activate R
    R->>DS: getNeoFeed(startDate, endDate)
    activate DS
    DS->>API: GET /neo/feed?start_date=...
    activate API
    API-->>DS: JSON Response
    deactivate API
    DS->>DS: Parse to NeoFeedModel
    DS-->>R: NeoFeedModel
    deactivate DS
    R->>R: Convert to Entity
    R-->>UC: Either<Failure, NeoFeedEntity>
    deactivate R
    UC-->>C: Either<Failure, NeoFeedEntity>
    deactivate UC
    C->>C: emit(Loaded) or emit(Error)
    C-->>UI: State Update
    deactivate C
    UI->>UI: Rebuild with new data
```

### Impact Calculator Flow

```mermaid
sequenceDiagram
    participant UI as Impact Page
    participant C as ImpactCalculatorCubit
    participant UC as CalculateImpact UseCase
    participant R as ImpactCalculatorRepository
    participant S as ImpactCalculationService
    
    UI->>C: Calculate Impact
    C->>C: emit(Calculating)
    C->>UC: call(AsteroidParameters)
    UC->>R: calculateImpact(params)
    R->>S: performCalculations(params)
    S->>S: Calculate energy, crater, seismic, tsunami
    S-->>R: ImpactResultModel
    R-->>UC: Either<Failure, ImpactResult>
    UC-->>C: Either<Failure, ImpactResult>
    C->>C: emit(CalculationComplete)
    C-->>UI: State Update
    UI->>UI: Display results & visualizations
```

---

## 🔧 Dependency Injection

NeoGuard uses **GetIt** for dependency injection, providing a service locator pattern for managing dependencies.

### Dependency Graph

```mermaid
graph TD
    SL[Service Locator]
    
    subgraph "Cubits - Factory"
        DC[DashboardCubit]
        IC[ImpactCalculatorCubit]
        NC[NasaEyesCubit]
        MC[MeteorMadnessCubit]
    end
    
    subgraph "Use Cases - Lazy Singleton"
        GNF[GetNeoFeed]
        CI[CalculateImpact]
    end
    
    subgraph "Repositories - Lazy Singleton"
        NR[NeoRepository]
        ICR[ImpactCalculatorRepository]
    end
    
    subgraph "Data Sources - Lazy Singleton"
        NRDS[NeoRemoteDataSource]
        ICS[ImpactCalculationService]
    end
    
    subgraph "External - Lazy Singleton"
        HTTP[HTTP Client]
    end
    
    SL --> DC
    SL --> IC
    SL --> NC
    SL --> MC
    
    DC --> GNF
    IC --> CI
    
    GNF --> NR
    CI --> ICR
    
    NR --> NRDS
    ICR --> ICS
    
    NRDS --> HTTP
    
    style SL fill:#ffeb3b
    style DC fill:#81c784
    style IC fill:#81c784
    style NC fill:#81c784
    style MC fill:#81c784
    style GNF fill:#64b5f6
    style CI fill:#64b5f6
    style NR fill:#ba68c8
    style ICR fill:#ba68c8
    style NRDS fill:#ff8a65
    style ICS fill:#ff8a65
    style HTTP fill:#e57373
```

### Initialization Flow

```mermaid
graph LR
    A[main.dart] -->|1. Initialize| B[WidgetsFlutterBinding]
    B -->|2. Setup DI| C[service_locator.init]
    C -->|3. Register| D[External Dependencies]
    C -->|4. Register| E[Data Sources]
    C -->|5. Register| F[Repositories]
    C -->|6. Register| G[Use Cases]
    C -->|7. Register| H[Cubits]
    H -->|8. Run App| I[NeoGuardApp]
    
    style A fill:#4caf50
    style C fill:#2196f3
    style I fill:#f44336
```

---

## 🗺️ Navigation Flow

### Route Structure

```mermaid
graph TD
    Home[Home Page<br/>'/']
    
    Home --> Dashboard[NEO Dashboard<br/>'/dashboard']
    Home --> Impact[Asteroid Impact<br/>'/asteroid-impact']
    Home --> Eyes[NASA Eyes<br/>'/nasa-eyes']
    Home --> Education[Education Center<br/>'/education']
    Home --> Meteor[Meteor Madness<br/>'/meteor-madness']
    
    Meteor --> Level[Level Selection]
    Level --> Play[Game Play<br/>'/meteor-madness/play']
    
    Education --> Definitions[Definitions<br/>'/education/definitions']
    Education --> Videos[Videos<br/>'/education/videos']
    Education --> Quiz[Quiz Levels<br/>'/quiz']
    
    style Home fill:#4caf50
    style Dashboard fill:#2196f3
    style Impact fill:#ff9800
    style Eyes fill:#9c27b0
    style Education fill:#00bcd4
    style Meteor fill:#e91e63
```

### Navigation Implementation

The app uses Flutter's imperative navigation with a centralized `AppRoutes` class:

```dart
// Route names defined in Routes class
class Routes {
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String asteroidImpact = '/asteroid-impact';
  // ... more routes
}

// Navigation usage
Navigator.pushNamed(context, Routes.dashboard);
```

Each route automatically provides the necessary BLoC/Cubit instances through `BlocProvider`:

```dart
case Routes.dashboard:
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => sl<DashboardCubit>(),
      child: const DashboardPage(),
    ),
  );
```

---

## 🎯 State Management

### BLoC/Cubit Pattern

NeoGuard uses the **Cubit** pattern (simplified BLoC) for state management:

```mermaid
stateDiagram-v2
    [*] --> Initial
    Initial --> Loading: Load Data
    Loading --> Loaded: Success
    Loading --> Error: Failure
    Loaded --> Loading: Refresh
    Error --> Loading: Retry
    Loaded --> [*]
    Error --> [*]
```

### Example: Dashboard States

```dart
// State definitions
abstract class DashboardState extends Equatable {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final NeoFeedEntity neoFeed;
}

class DashboardError extends DashboardState {
  final String message;
}
```

### State Flow Example

```mermaid
graph LR
    A[User Action] --> B{Cubit Method}
    B --> C[Emit Loading]
    C --> D[Call Use Case]
    D --> E{Result}
    E -->|Success| F[Emit Loaded]
    E -->|Failure| G[Emit Error]
    F --> H[UI Rebuilds]
    G --> H
    
    style A fill:#4caf50
    style B fill:#2196f3
    style D fill:#ff9800
    style E fill:#9c27b0
    style H fill:#e91e63
```

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: >=3.9.0
- **Dart SDK**: >=3.9.0
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA
- **Platforms**: Android, iOS, Web, Windows, Linux, macOS

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/neo_guard.git
   cd neo_guard
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Run on your default device
   flutter run
   
   # Or specify a platform
   flutter run -d chrome        # Web
   flutter run -d windows       # Windows
   flutter run -d android       # Android
   flutter run -d ios          # iOS
   ```

### Building for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

---

## 📦 Key Dependencies

### Core Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^9.1.1 | State management |
| `get_it` | ^8.2.0 | Dependency injection |
| `dartz` | ^0.10.1 | Functional programming (Either, Option) |
| `equatable` | ^2.0.5 | Value equality for states |
| `http` | ^1.1.0 | HTTP client for API calls |
| `flutter_screenutil` | ^5.9.3 | Responsive UI design |

### Feature-Specific Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flame` | ^1.18.0 | Game engine (Meteor Madness) |
| `flame_audio` | ^2.1.0 | Game audio |
| `webview_flutter` | ^4.4.2 | NASA Eyes WebView |
| `video_player` | ^2.10.0 | Educational videos |
| `url_launcher` | ^6.2.1 | External links |
| `intl` | ^0.19.0 | Date formatting |
| `iconsax_flutter` | ^1.0.1 | Icon library |

### Development Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Testing framework |
| `bloc_test` | ^10.0.0 | BLoC testing utilities |
| `mocktail` | ^1.0.4 | Mocking library |
| `build_runner` | ^2.4.6 | Code generation |
| `flutter_lints` | ^6.0.0 | Linting rules |

---

## 🧪 Testing

### Test Structure

```
test/
├── core/
│   ├── network/
│   └── di/
├── features/
│   ├── dashboard/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── asteroid_impact/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── helpers/
```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/dashboard/presentation/cubit/dashboard_cubit_test.dart
```

### Test Example

```dart
blocTest<DashboardCubit, DashboardState>(
  'emits [Loading, Loaded] when getNeoFeed is successful',
  build: () {
    when(() => mockGetNeoFeed(any()))
        .thenAnswer((_) async => Right(mockNeoFeed));
    return DashboardCubit(mockGetNeoFeed);
  },
  act: (cubit) => cubit.loadNeoFeed(startDate, endDate),
  expect: () => [
    DashboardLoading(),
    DashboardLoaded(mockNeoFeed),
  ],
);
```

---

## 🌐 API Integration

### NASA NeoWs API

NeoGuard integrates with NASA's Near Earth Object Web Service (NeoWs):

**Base URL**: `https://api.nasa.gov/neo/rest/v1`

**Endpoints Used**:
- `/feed` - Retrieve a list of NEOs based on date range

**Authentication**: API Key required (included in source)

### Example Request Flow

```mermaid
sequenceDiagram
    participant App
    participant DataSource
    participant NASA API
    
    App->>DataSource: getNeoFeed(startDate, endDate)
    DataSource->>NASA API: GET /feed?start_date=2025-10-01&end_date=2025-10-07
    NASA API-->>DataSource: 200 OK + JSON Data
    DataSource->>DataSource: Parse JSON to NeoFeedModel
    DataSource-->>App: NeoFeedModel
```

### Error Handling

```dart
try {
  final response = await client.get(url);
  
  if (response.statusCode == 200) {
    return NeoFeedModel.fromJson(json.decode(response.body));
  } else if (response.statusCode == 429) {
    throw Exception('API rate limit exceeded');
  } else if (response.statusCode == 400) {
    throw Exception('Invalid date range');
  }
} catch (e) {
  throw Exception('Network error: $e');
}
```

---

## 🎨 Design System

### Color Palette

- **Primary**: Blue (#2196F3) - Trust, space theme
- **Secondary**: Purple (#9C27B0) - Innovation, mystery
- **Accent**: Indigo (#3F51B5) - Depth, sophistication
- **Success**: Green (#4CAF50) - Safe, positive
- **Warning**: Orange (#FF9800) - Caution, attention
- **Danger**: Red (#F44336) - Hazard, critical

### Theme Configuration

```dart
// Dark theme optimized for space aesthetic
ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.blue600,
  scaffoldBackgroundColor: AppColors.background,
  // ... more configuration
)
```

### Responsive Design

Using `flutter_screenutil` for responsive layouts:

```dart
ScreenUtilInit(
  designSize: const Size(375, 812), // iPhone X base
  minTextAdapt: true,
  splitScreenMode: true,
  // ...
)
```

---

## 🎮 Game Architecture (Meteor Madness)

### Flame Engine Integration

```mermaid
graph TD
    subgraph "Flame Game"
        Game[MeteorMadnessGame]
        Player[PlayerComponent]
        Meteor[MeteorComponent]
        Projectile[LaserProjectile]
        Planet[PlanetComponent]
        Starfield[StarfieldComponent]
    end
    
    subgraph "Game Systems"
        WS[WeaponSystem]
        CU[CannonUpgradeSystem]
        Col[CollisionDetection]
    end
    
    subgraph "UI Overlays"
        HUD[GameHUD]
        GO[GameOverOverlay]
        WC[WaveCompleteOverlay]
    end
    
    Game --> Player
    Game --> Meteor
    Game --> Projectile
    Game --> Planet
    Game --> Starfield
    
    Player --> WS
    Player --> CU
    
    Game --> Col
    Game --> HUD
    Game --> GO
    Game --> WC
    
    style Game fill:#4caf50
    style Player fill:#2196f3
    style WS fill:#ff9800
```

### Game Loop

```mermaid
sequenceDiagram
    participant FL as Flame Loop
    participant Game
    participant Player
    participant Meteors
    participant Collision
    
    loop Every Frame
        FL->>Game: update(dt)
        Game->>Player: update(dt)
        Game->>Meteors: update(dt)
        Meteors->>Meteors: Move towards planet
        Game->>Collision: Check collisions
        Collision->>Game: Handle impacts
        FL->>Game: render(canvas)
        Game->>Player: render(canvas)
        Game->>Meteors: render(canvas)
    end
```

---

## 📱 Screenshots & Features

### Feature Matrix

| Feature | Dashboard | Impact Calc | NASA Eyes | Education | Game |
|---------|-----------|-------------|-----------|-----------|------|
| Real-time Data | ✅ | ❌ | ✅ | ❌ | ❌ |
| Interactive | ✅ | ✅ | ✅ | ✅ | ✅ |
| Educational | ✅ | ✅ | ✅ | ✅ | ✅ |
| Gamified | ❌ | ❌ | ❌ | ✅ | ✅ |
| Offline Mode | ❌ | ✅ | ❌ | ✅ | ✅ |

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Follow the existing architecture** (Clean Architecture + Feature-based)
4. **Write tests** for new features
5. **Update documentation** as needed
6. **Commit changes** (`git commit -m 'Add amazing feature'`)
7. **Push to branch** (`git push origin feature/amazing-feature`)
8. **Open a Pull Request**

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter_lints` package rules
- Format code with `flutter format .`
- Run analyzer: `flutter analyze`

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Authors

- **Your Name** - *Initial work*

---

## 🙏 Acknowledgments

- **NASA** - For providing the NEO API and Eyes on Asteroids visualization
- **Flutter Team** - For the amazing framework
- **Flame Engine** - For the game engine
- **Open Source Community** - For the excellent packages used in this project

---

## 📞 Support

For support, email support@neoguard.app or open an issue in the repository.

---

## 🗺️ Roadmap

### Version 1.1
- [ ] Add user authentication
- [ ] Implement local caching for offline mode
- [ ] Add more quiz questions
- [ ] Implement leaderboard system

### Version 1.2
- [ ] Add asteroid 3D visualization
- [ ] Implement push notifications for close approaches
- [ ] Add social sharing features
- [ ] Multi-language support

### Version 2.0
- [ ] AR features for asteroid visualization
- [ ] Community features and discussions
- [ ] Advanced impact simulation with machine learning
- [ ] Integration with more NASA APIs

---

## 📊 Project Statistics

- **Lines of Code**: ~15,000+
- **Number of Features**: 6
- **Test Coverage**: Target 80%
- **Supported Platforms**: 6 (Android, iOS, Web, Windows, Linux, macOS)

---

<div align="center">

**Made with ❤️ and ☕ by the NeoGuard Team**

[Website](https://neoguard.app) • [Documentation](https://docs.neoguard.app) • [Report Bug](https://github.com/yourusername/neo_guard/issues) • [Request Feature](https://github.com/yourusername/neo_guard/issues)

</div>
