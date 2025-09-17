# Development Patterns and Guidelines

## MVVM + Repository Architecture

### ViewModel Pattern (Riverpod)
```dart
@riverpod
class MyFeatureViewModel extends _$MyFeatureViewModel {
  @override
  FutureOr<MyState> build() {
    // Initialize state
    return MyState.initial();
  }
  
  Future<void> performAction() async {
    state = const AsyncLoading();
    try {
      final result = await ref.read(myRepositoryProvider).getData();
      state = AsyncData(MyState.success(result));
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
```

### Repository Pattern
```dart
abstract class MyRepository {
  Future<MyModel> getData();
}

class MyRepositoryImpl implements MyRepository {
  @override
  Future<MyModel> getData() async {
    try {
      // API call
      final data = await _apiCall();
      return MyModel.fromJson(data);
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    }
  }
}
```

## Error Handling Strategy

### Custom Exception Classes
- `AppException` base class for all app errors
- Domain-specific exceptions (AuthException, PaymentException)
- Consistent error conversion at repository boundaries

### Error Flow
1. **External API** → Raw exceptions (Firebase, Stripe)
2. **Repository** → Convert to AppException
3. **ViewModel** → Handle AppException, update UI state  
4. **UI** → Display user-friendly error messages

## State Management with Riverpod

### Provider Types
- `@riverpod` - For all new providers
- `AsyncNotifier` - For async state management
- `Notifier` - For synchronous state management
- Family providers for parameterized providers

### Best Practices
- Use generators exclusively (`@riverpod`)
- Keep ViewModels focused on single responsibility
- Handle loading/error states consistently
- Avoid direct Firebase calls in UI layer

## Firebase Functions Patterns

### Function Organization
- Domain-based structure (auth/, business/, payment/)
- Consistent naming: `v2_[domain]_[entity]_[action]`
- Service layer for business logic
- Utility functions for common operations

### Error Handling in Functions
```typescript
export const myFunction = onCall(async (request) => {
  try {
    // Function logic
    return { success: true, data: result };
  } catch (error) {
    logger.error('Function failed', error);
    throw new HttpsError('internal', 'Operation failed');
  }
});
```

## Testing Patterns
- Unit tests for business logic
- Widget tests for UI components
- Integration tests with mock providers
- Firebase emulator for function testing

## Security Considerations
- No secrets in client code
- Server-side validation for all operations
- Proper Firestore security rules
- Stripe webhook signature verification