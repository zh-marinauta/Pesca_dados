## Quick context for AI coding agents

This is a Flutter application (multi-platform) named `marinuata_app`. Key facts an AI should know before changing code:

- Entry point: `lib/main.dart` — app initializes Firebase (wrapped in a tolerant try/catch) and selects the home via
  a `StreamBuilder` on `FirebaseAuth.instance.authStateChanges()`.
- Authentication UI and logic: `lib/screens/login_screen.dart` — uses `firebase_auth` to sign in and maps Firebase error codes to Portuguese messages.
- Dependencies of note (see `pubspec.yaml`): `firebase_core`, `firebase_auth`, and `gap`. Avoid changing major dependency versions without confirming compatibility.

## Architecture and patterns

- Small, screen-based structure: UI lives under `lib/screens/`. Keep widgets small and prefer extracting reusable UI into `lib/widgets/` if needed.
- State: mostly local widget state (see `LoginScreen`), with Firebase Auth used as global auth state via streams in `main.dart`.
- The app uses Material 3 with a seed color (0xFF005CA9). Follow existing theming rather than introducing new global theme systems.

## Build / run / test workflows (commands)

- Install deps: `flutter pub get`
- Run on device/emulator: `flutter run -d <device_id>`
- Build (Android APK): `flutter build apk`
- Build (iOS): `flutter build ios` (requires macOS + Xcode)
- Run tests: `flutter test` (there is a `test/widget_test.dart`)
- Static checks: `flutter analyze` and `dart format .` for style

Notes: Firebase may require platform-specific setup (google-services.json / GoogleService-Info.plist). The app tolerantly calls `Firebase.initializeApp()` in `main.dart`; be careful when changing initialization.

## Project-specific conventions

- Language: code comments and UI strings are primarily Portuguese — keep new strings consistent with Portuguese unless requested otherwise.
- Naming: follow existing PascalCase for widgets (`MarinuataApp`, `LoginScreen`) and snake_case for filenames.
- Error handling: for Firebase auth errors, map `FirebaseAuthException.code` to user-facing messages (see `_tratarErroFirebase` in `login_screen.dart`). Reuse that mapping if adding other auth flows.

## Integration points / files to inspect before edits

- `lib/main.dart` — app lifecycle, Firebase init, auth stream, home selection
- `lib/screens/login_screen.dart` — login UI and auth handling
- `pubspec.yaml` — dependency versions
- `android/` and `ios/` — platform config, plugin registration; check `local.properties` and platform-specific Firebase files when changing native integrations
- `build/flutter_assets/` — generated assets during builds

## Example prompts to use when editing

- "Refactor the login flow to extract a reusable `AuthService` class that wraps `FirebaseAuth` and add unit tests for error mapping. Keep public behavior identical and reference `lib/screens/login_screen.dart` and `lib/main.dart`."
- "Add a sign-out confirmation dialog that uses the app's primary color and calls `FirebaseAuth.instance.signOut()`; update `HomeScreenPlaceholder` in `lib/main.dart`."

## Safety and risk guidance

- Avoid broad, automatic changes to dependency versions (firebase packages are sensitive). If you must update them, run `flutter pub get` and `flutter test`.
- Preserve Portuguese UI text unless asked to internationalize. Keep changes minimal and provide a short summary of behavior and files changed in your PR description.

If any of this is unclear or you'd like more detail in a specific area (testing, CI, Firebase config, or adding state management), tell me which section to expand.
