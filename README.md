# FakeStore

A Flutter shopping app for browsing products from the FakeStore API, viewing product information, managing a cart, and signing in.

## Features

- Product browsing backed by HTTP requests
- Cart and product state managed with Provider
- Login and session persistence support
- Flutter UI components for loading/progress feedback

> This repository is a learning project. Some features may depend on the API and implementation currently present in the source.

## Tech stack

- Flutter and Dart
- Provider
- HTTP
- Shared Preferences

## Getting started

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Clone this repository and open its directory.
3. Fetch packages and run the app:

   ```bash
   flutter pub get
   flutter run
   ```

## Checks

```bash
flutter analyze
flutter test
```

## Project structure

Application code is under `lib/`, including product/cart state and the app's views. Platform-specific runner projects are provided by Flutter.

## License

No license is currently specified. Contact the repository owner before reuse or redistribution.
