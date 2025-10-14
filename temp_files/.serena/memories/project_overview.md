# TLINY Project Overview

## Purpose
TLINY is a digital bazaar platform for schools that modernizes traditional bazaar operations through digital payments and real-time management. It enables schools to run digital markets/bazaars with online payment processing.

## Tech Stack
- **Frontend**: Flutter Web (Dart)
- **State Management**: Riverpod with generators (`@riverpod`, `hooks_riverpod`)
- **UI Framework**: Material Design with responsive sizing
- **Backend**: Firebase Cloud Functions (TypeScript v20) with v2 architecture
- **Database**: Cloud Firestore
- **Authentication**: Firebase Auth with Google Sign-in
- **Payment Processing**: Stripe integration
- **Routing**: GoRouter with type-safe routing
- **Build System**: build_runner for code generation
- **Package Management**: FVM (Flutter Version Management) + yarn
- **Deployment**: Firebase Hosting for web builds

## Key Libraries
- **Flutter**: Riverpod, Freezed, JSON Annotation, GoRouter
- **Firebase**: Full Firebase suite (Auth, Firestore, Functions, Analytics, etc.)
- **UI Components**: Google Fonts, Font Awesome, Responsive Sizer
- **Development**: build_runner, custom_lint, riverpod_lint
- **Testing**: mockito, fake_cloud_firestore

## Architecture Pattern
- **MVVM + Repository Pattern**
- **Domain-driven design** in Firebase Functions (v2)
- **Clean Architecture** with clear layer separation
- **Code generation** for models, providers, and routing