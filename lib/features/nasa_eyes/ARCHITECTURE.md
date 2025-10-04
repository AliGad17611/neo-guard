# 🏗️ NASA Eyes Architecture

## 📐 Clean Architecture Structure

```
nasa_eyes/
│
├── presentation/                    # Presentation Layer
│   │
│   ├── cubit/                      # State Management
│   │   ├── nasa_eyes_cubit.dart   # Business logic & WebView control
│   │   └── nasa_eyes_state.dart   # State definitions
│   │
│   ├── pages/                      # Screens
│   │   └── nasa_eyes_page.dart    # Main page (StatelessWidget)
│   │
│   └── widgets/                    # Reusable UI Components
│       ├── error_view.dart        # Error display with retry
│       ├── loading_view.dart      # Loading indicator
│       └── webview_actions.dart   # App bar refresh button
│
├── README.md                       # Feature documentation
├── REFACTORING_SUMMARY.md         # Refactoring details
├── ARCHITECTURE.md                 # This file
└── USAGE_EXAMPLE.md               # Usage examples
```

## 🔄 State Flow Diagram

```
                    ┌─────────────────┐
                    │  NasaEyesPage   │
                    │ (StatelessWidget)│
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  BlocBuilder     │
                    │  (State Listener)│
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │ NasaEyesCubit    │
                    │ (State Manager)  │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
  ┌─────▼──────┐      ┌─────▼──────┐      ┌─────▼──────┐
  │  Initial   │      │  Loading   │      │   Loaded   │
  └────────────┘      └────────────┘      └────────────┘
                             │
                      ┌──────▼──────┐
                      │    Error    │
                      └─────────────┘
```

## 📊 State Transitions

```
Initial State
    │
    ├──► Loading (onPageStarted)
    │       │
    │       ├──► Loaded (onPageFinished)
    │       │
    │       └──► Error (onWebResourceError)
    │               │
    │               └──► Loading (retry)
    │
    └──► Loading (manual refresh)
            │
            └──► Loaded / Error
```

## 🧩 Component Interaction

```
┌─────────────────────────────────────────────────┐
│                 NasaEyesPage                    │
│  ┌──────────────────────────────────────────┐  │
│  │           AppBar                         │  │
│  │  ┌────────────────────────────────────┐  │  │
│  │  │      WebViewActions Widget         │  │  │
│  │  │  • Refresh button                  │  │  │
│  │  │  • Calls cubit.reload()            │  │  │
│  │  └────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────┘  │
│                                                 │
│  ┌──────────────────────────────────────────┐  │
│  │         BlocBuilder<NasaEyesCubit>       │  │
│  │  ┌────────────────────────────────────┐  │  │
│  │  │  State: Initial / Loading          │  │  │
│  │  │  ┌──────────────────────────────┐  │  │  │
│  │  │  │    LoadingView Widget        │  │  │  │
│  │  │  │  • Progress indicator        │  │  │  │
│  │  │  │  • "Loading NASA Eyes..."    │  │  │  │
│  │  │  └──────────────────────────────┘  │  │  │
│  │  └────────────────────────────────────┘  │  │
│  │                                          │  │
│  │  ┌────────────────────────────────────┐  │  │
│  │  │  State: Error                      │  │  │
│  │  │  ┌──────────────────────────────┐  │  │  │
│  │  │  │    ErrorView Widget          │  │  │  │
│  │  │  │  • Error icon                │  │  │  │
│  │  │  │  • Error message             │  │  │  │
│  │  │  │  • Retry button              │  │  │  │
│  │  │  │    → calls cubit.retry()     │  │  │  │
│  │  │  └──────────────────────────────┘  │  │  │
│  │  └────────────────────────────────────┘  │  │
│  │                                          │  │
│  │  ┌────────────────────────────────────┐  │  │
│  │  │  State: Loaded                     │  │  │
│  │  │  ┌──────────────────────────────┐  │  │  │
│  │  │  │    WebViewWidget             │  │  │  │
│  │  │  │  • Uses cubit.controller     │  │  │  │
│  │  │  │  • Displays NASA Eyes        │  │  │  │
│  │  │  └──────────────────────────────┘  │  │  │
│  │  └────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

## 🎯 Dependency Injection Flow

```
1. App Initialization
   └─► service_locator.init()
       └─► sl.registerFactory(() => NasaEyesCubit())

2. Navigation to NASA Eyes
   └─► Navigator.pushNamed(Routes.nasaEyes)
       └─► AppRoutes.generateRoute()
           └─► BlocProvider(
               create: (_) => di.sl<NasaEyesCubit>()
               child: NasaEyesPage()
             )

3. Page Renders
   └─► NasaEyesPage
       └─► BlocBuilder<NasaEyesCubit, NasaEyesState>
           └─► Listens to state changes
               └─► Rebuilds UI accordingly
```

## 🔧 Cubit Responsibilities

### NasaEyesCubit
- **Initialize WebView**: Sets up WebViewController with configuration
- **Manage States**: Emits states based on page lifecycle
- **Handle Navigation**: Delegates page events (start, finish, error)
- **Provide Controller**: Exposes WebViewController to UI
- **Reload Function**: Triggers page refresh
- **Retry Function**: Attempts to reload after error

## 📱 Widget Responsibilities

### NasaEyesPage
- **Scaffold Structure**: Provides app bar and body
- **BlocBuilder Integration**: Listens to cubit states
- **Widget Composition**: Renders appropriate widgets based on state

### LoadingView
- **Loading Indicator**: Shows circular progress
- **Loading Message**: Displays "Loading NASA Eyes..."
- **Theme Consistency**: Uses app colors

### ErrorView
- **Error Display**: Shows error icon and message
- **Retry Action**: Provides retry button
- **User Feedback**: Clear error communication

### WebViewActions
- **Refresh Button**: App bar action for reload
- **Cubit Interaction**: Calls cubit methods
- **Tooltip**: Provides user guidance

## 🎨 Design Patterns Used

1. **BLoC Pattern**: State management with Cubit
2. **Dependency Injection**: GetIt service locator
3. **Factory Pattern**: Cubit registration
4. **Widget Composition**: Extracted reusable widgets
5. **Clean Architecture**: Separation of concerns
6. **Equatable Pattern**: State equality comparison

