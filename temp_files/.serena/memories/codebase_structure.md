# Codebase Structure

## Root Directory Structure
```
tliny/
├── lib/                    # Flutter application code
├── functions/              # Firebase Cloud Functions
├── emulator/              # Firebase emulator data
├── assets/                # App assets (images, fonts, files)
├── test/                  # Test files
├── web/, android/, ios/   # Platform-specific code
├── Makefile              # Development commands
├── pubspec.yaml          # Flutter dependencies
├── firebase.json         # Firebase configuration
└── CLAUDE.md            # Project documentation
```

## Flutter App Structure (`lib/`)
```
lib/
├── main.dart             # App entry point
├── src/
│   ├── app.dart         # Main app widget
│   ├── ui/              # User interface layer
│   │   ├── auth/        # Authentication screens
│   │   ├── cart/        # Shopping cart features
│   │   ├── checkout/    # Payment checkout
│   │   ├── common/      # Shared UI components
│   │   ├── ticket/      # Event ticket management
│   │   └── [other]/     # Other feature modules
│   ├── data/            # Data layer
│   │   ├── model/       # Data models (Freezed classes)
│   │   └── repository/  # Data access layer
│   ├── utils/           # Utility functions
│   └── settings/        # App configuration
├── gen/                 # Generated assets
└── foundation/          # Core foundations
```

## Firebase Functions Structure (`functions/src/`)
```
functions/src/
├── index.ts             # Function exports
├── v2/                  # Current function version
│   ├── auth/           # User authentication triggers
│   ├── business/       # Business logic (orders, products, tickets)
│   ├── payment/        # Stripe payment integration
│   ├── firestore/      # Firestore database triggers
│   └── index.ts        # V2 function exports
├── utils/              # Shared utilities
└── v1/                 # Legacy functions (deprecated)
```

## Key Architecture Layers

### UI Layer (`lib/src/ui/`)
- **Pages**: Main screen widgets
- **ViewModels**: Business logic with Riverpod
- **Widgets**: Reusable UI components
- **States**: Data classes for UI state

### Data Layer (`lib/src/data/`)
- **Models**: Freezed data classes with JSON serialization
- **Repositories**: Abstract data access with error handling
- **Providers**: Riverpod providers for dependency injection

### Firebase Functions (`functions/src/v2/`)
- **Domain Organization**: Grouped by business domain
- **Service Layer**: Business logic services
- **Error Handling**: Centralized error management
- **Stripe Integration**: Payment processing workflows

## Generated Files (Git-ignored)
- `**/*.g.dart` - JSON serialization
- `**/*.freezed.dart` - Freezed immutable classes  
- `**/*.gr.dart` - GoRouter routing
- `functions/lib/` - Compiled TypeScript