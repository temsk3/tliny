# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

TLINY is a school bazaar/marketplace Flutter web app with Firebase backend and Stripe payments. See `.cursorrules` for full architecture details.

### Services

| Service | Port | Purpose |
|---------|------|---------|
| Flutter Web (via Firebase Hosting emulator) | 5002 | Frontend app |
| Firebase Auth emulator | 9099 | Authentication |
| Firestore emulator | 8081 | Database |
| Cloud Functions emulator | 5001 | Backend (Stripe, business logic) |
| Firebase Storage emulator | 9199 | File storage |
| Firebase Emulator UI | 4000 | Emulator dashboard |

### Running the app

1. Start Firebase emulators: `firebase emulators:start --import=./emulator/data --export-on-exit=./emulator/data`
2. Build Flutter web: `fvm flutter build web --dart-define=FLAVOR=dev --target lib/main.dart`
3. The hosting emulator serves `build/web` on port 5002 automatically.
4. For dev mode with hot reload: `fvm flutter run -d chrome --web-renderer html --dart-define=FLAVOR=dev --target lib/main.dart`
5. See `Makefile` for all available commands (`make run-dev`, `make run-emulator`, etc.)

### Key caveats

- **Node.js 20 required**: Cloud Functions require Node.js 20 (`functions/package.json` `engines.node: "20"`). Use `nvm use 20` before running emulators or npm commands in `functions/`.
- **FVM required**: All Flutter commands use `fvm flutter ...`. Flutter 3.32.5 is pinned in `.fvmrc`. FVM standalone installer: `curl -fsSL https://fvm.app/install.sh | bash`.
- **build_runner must run after pub get**: Generated files (`.g.dart`, `.freezed.dart`) are gitignored. Run `fvm flutter packages pub run build_runner build --delete-conflicting-outputs` after any model/provider changes.
- **flutter clean needed on first setup**: The `.dart_tool` directory may contain stale paths from the original developer's machine. Run `fvm flutter clean && fvm flutter pub get` on first setup.
- **Pre-existing test failures**: ~59 test failures exist due to outdated mocks and type mismatches in `test/` (mainly widget and usage_history tests). These are not caused by environment setup.
- **Emulator data**: Seed data lives in `emulator/data/` and is imported on emulator start. Use `--import=./emulator/data --export-on-exit=./emulator/data` flags.
- **Dev flavor connects to emulators automatically**: When `FLAVOR=dev` and in debug mode, `main.dart` auto-connects to Firebase emulators on localhost.

### Lint / Test / Build

- Lint: `fvm flutter analyze` (see `Makefile` `analyze` target)
- Test: `fvm flutter test` (see `Makefile` `test` target)
- Build web: `fvm flutter build web --dart-define=FLAVOR=dev --target lib/main.dart`
- Build functions: `cd functions && npm run build`
- Functions lint: `cd functions && npm run lint:eslint`
