# Task Completion Checklist

## Before Committing Code Changes

### 1. Code Generation
```bash
make build-runner            # Ensure all generated files are up to date
```

### 2. Code Quality Checks
```bash
make format                  # Format all Dart code
make analyze                 # Check for lint issues and errors
make test                    # Run all tests
```

### 3. Firebase Functions (if modified)
```bash
cd functions
npm run build               # Ensure TypeScript compiles
npm run lint:eslint         # Check for ESLint issues
npm run fix:prettier        # Format TypeScript code
```

### 4. Local Testing
```bash
make run-emulator           # Test with Firebase emulators
make run-dev                # Test in development mode
```

### 5. Build Verification
```bash
make build-prod             # Ensure production build works
```

## Critical Requirements
- **Never commit generated files** (*.g.dart, *.freezed.dart, *.gr.dart)
- **Always regenerate code** after model changes
- **Test locally** with emulators before deploying
- **Check Firebase console** for function deployment status
- **Verify Stripe webhooks** work in test mode

## Error Resolution
- If `make analyze` fails: Fix all reported issues
- If `make test` fails: Fix failing tests or update expectations  
- If build fails: Check for missing dependencies or syntax errors
- If functions fail to deploy: Check Firebase project permissions

## Final Steps
1. Verify all checklist items pass
2. Commit with descriptive message
3. Deploy functions if needed: `cd functions && npm run deploy`
4. Monitor Firebase console for any runtime errors