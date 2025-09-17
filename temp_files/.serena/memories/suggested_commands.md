# Essential Development Commands

## Setup & Dependencies
```bash
# Initial project setup
make setup                    # Install FVM, Flutter, and dependencies
make dependencies            # Install Flutter packages
make clean                   # Clean Flutter build cache
```

## Code Generation & Quality
```bash
# CRITICAL: Always run after model changes
make build-runner            # Generate code (*.g.dart, *.freezed.dart files)
make build-runner-watch      # Continuous code generation during development

# Code quality
make format                  # Format Dart code
make analyze                 # Analyze code for issues
make test                    # Run Flutter tests
```

## Development Server
```bash
# Run development
make run-dev                 # Start dev server on Chrome
make run-dev-preview         # Start with device preview mode
make run-emulator           # Start Firebase emulators with data import/export
```

## Production Builds
```bash
make build-prod             # Build for web production
make run-prod               # Run production build locally
```

## Firebase Functions (in functions/ directory)
```bash
cd functions
npm install                 # Install dependencies
npm run build              # Build TypeScript
npm run serve              # Start emulator with functions only
npm run deploy             # Deploy functions to Firebase
npm run lint:eslint        # Lint TypeScript code
npm run fix:prettier       # Format code with Prettier
```

## System Commands (macOS)
```bash
# Standard macOS/Unix commands available
ls, cd, grep, find, git     # File system and version control
```

## Critical Workflow
1. Always run `make build-runner-watch` during development
2. Use `make run-emulator` for local development with Firebase
3. Run `make analyze` and `make format` before commits
4. Never commit generated files (*.g.dart, *.freezed.dart)