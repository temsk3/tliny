# Code Style and Conventions

## General Naming Conventions
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Private members**: prefix with underscore `_`

## Dart/Flutter Conventions
- Use `pedantic_mono` linter rules (analysis_options.yaml)
- Generated files excluded from analysis (*.g.dart, *.freezed.dart)
- Ignore `lines_longer_than_80_chars` and `invalid_annotation_target`
- Prefer single quotes for strings (when enabled)

## Riverpod State Management
- Always use generators: `@riverpod`
- ViewModels extend `AsyncNotifier` or `Notifier`
- Provider naming: `[name]Provider`
- Generated providers end with `Provider` suffix

## Model Classes (Freezed Pattern)
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

## Repository Pattern
- Abstract data access in repository layer
- Convert external API errors to custom `AppException`
- Consistent error handling across layers

## Firebase Functions (TypeScript)
- Use ESLint with Google config and Prettier
- Function naming: `v2_[domain]_[entity]_[action]`
- Domain-based organization: auth/, business/, payment/, firestore/
- Node.js 20 runtime

## File Organization
- **UI**: `lib/src/ui/[feature]/` (pages, widgets, view_models)
- **Data**: `lib/src/data/model/`, `lib/src/data/repository/`
- **Utils**: `lib/src/utils/`
- **Generated**: Excluded from Git, regenerated as needed

## Code Generation Requirements
- Run `build_runner` after any model changes
- Generated files (.g.dart, .freezed.dart) are Git-ignored
- Use `make build-runner-watch` during active development