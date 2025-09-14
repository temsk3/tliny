# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TLINY is a digital bazaar platform for schools that modernizes traditional bazaar operations through digital payments and real-time management. The application is built using Flutter Web for the frontend and Firebase (with Cloud Functions) + Stripe for the backend services.

## Architecture

- **Frontend**: Flutter Web with MVVM + Repository pattern
- **State Management**: Riverpod with generators (`@riverpod`)
- **Backend**: Firebase Cloud Functions (TypeScript) with v2 structure
- **Database**: Cloud Firestore
- **Payments**: Stripe integration
- **Routing**: GoRouter with type-safe routing

## Common Development Commands

### Flutter Development

```bash
# Setup project
make setup

# Install dependencies
make dependencies
flutter pub get

# Code generation (always run after model changes)
make build-runner
# Or for continuous generation during development:
make build-runner-watch

# Run development server
make run-dev
# With device preview:
make run-dev-preview

# Code quality
make format
make analyze
flutter test

# Build for production
make build-prod
```

### Firebase Functions Development

```bash
# Navigate to functions directory
cd functions

# Install dependencies
npm install

# Build TypeScript
npm run build

# Start emulator with functions
npm run serve

# Deploy functions only
npm run deploy

# Lint and format
npm run lint:eslint
npm run fix:prettier
```

### Firebase Emulator

```bash
# Start Firebase emulators with data import/export
make run-emulator
# Equivalent to: firebase emulators:start --import=./emulator/data --export-on-exit=./emulator/data
```

## Code Architecture Details

### Flutter Application Structure

The Flutter app follows MVVM + Repository pattern with clear separation:

- **Views** (`lib/src/ui/`): UI widgets that only handle presentation
- **ViewModels** (`*_view_model.dart`): Business logic using Riverpod `AsyncNotifier`/`Notifier`
- **Repositories** (`lib/src/data/repository/`): Data access abstraction
- **Models** (`lib/src/data/model/`): Freezed data classes with JSON serialization

Key architectural patterns:

- Use `@riverpod` generators for all providers
- Models use Freezed for immutability and JSON serialization
- Error handling through custom `AppException` classes
- Repository pattern abstracts Firebase/Stripe APIs

### Firebase Functions Architecture

Located in `functions/src/`, organized by version:

- **v2/** - Current active functions with domain-based organization:
  - `auth/` - User authentication triggers
  - `business/` - Business domain logic (orders, products, tickets)
  - `payment/` - Stripe payment integration
  - `firestore/` - Firestore triggers
- **utils/** - Shared utilities and error handling
- **services/** - Business logic services

Functions are exported with consistent naming: `v2_[domain]_[entity]_[action]`

### State Management with Riverpod

Always use Riverpod generators:

```dart
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  FutureOr<MyState> build() {
    // initialization
  }

  // methods for state updates
}
```

### Data Models with Freezed

All models use Freezed pattern:

```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel({
    required String id,
    // other fields
  }) = _MyModel;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

## Error Handling Strategy

The application uses unified error handling:

1. **Custom AppException classes** for consistent error representation
2. **Layer-specific error conversion**:
   - DataSource → Repository: Convert external API errors to AppException
   - Repository → ViewModel: Pass through AppException
   - ViewModel → UI: Convert to user-friendly messages
3. **UI error display** through consistent components (SnackBars, Dialogs)

## Development Workflow

1. **Always run `make build-runner-watch`** during development for code generation
2. **Use emulator** for local development: `make run-emulator`
3. **Follow naming conventions**:
   - Files: `snake_case`
   - Classes: `PascalCase`
   - Variables/Functions: `camelCase`
4. **Test commands**: `flutter test` for unit tests
5. **Code quality**: Run `make analyze` and `make format` before commits

## Stripe Integration

- **Client-side**: Use publishable keys only
- **Server-side**: Secret keys in Cloud Functions environment variables
- **Payment flow**: PaymentIntents created/confirmed via Cloud Functions
- **Webhooks**: Handled in `functions/src/v2/payment/webhook.ts`

## Important File Patterns

- Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from Git
- Always regenerate code after model changes
- Environment variables in `.env` for Flutter, functions use Firebase config
- Firestore security rules currently allow all access (development mode)

## Testing

- Unit tests in `test/unit/`
- Integration tests in `test/integration/`
- Widget tests for UI components
- Mock providers available in `test/integration/mock_providers.dart`
