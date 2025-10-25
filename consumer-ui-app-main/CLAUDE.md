# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter e-commerce consumer application (`black_locust`) that supports both Shopify and custom platform integrations. The app is configured for "9shineslabel" brand and uses a multi-platform architecture with GraphQL for data management.

## Development Commands

### Basic Flutter Commands
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle
- `flutter build ios` - Build iOS app
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter test` - Run unit tests

### Testing
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run specific test file

### Build & Release
- `flutter build apk --release` - Build release APK
- `flutter build appbundle --release` - Build release App Bundle for Play Store

## Architecture Overview

### Platform Architecture
The app supports two platforms controlled by `lib/config/configConstant.dart`:
- **Shopify**: Uses Shopify's GraphQL API and storefront
- **ToAutomation**: Uses custom backend with different GraphQL schema

Platform switching is done via the `platform` constant ('shopify' or 'to-automation').

### Key Architecture Components

#### State Management
- **GetX**: Primary state management using Get controllers
- **GraphQL Flutter**: For API data management with caching
- **Get Storage**: Local storage for app settings and user data

#### Navigation & Routing
- **GetX Navigation**: Declarative routing with bindings
- All routes defined in `lib/routes.dart` with corresponding bindings
- Route structure follows `/routeName` pattern (e.g., `/home`, `/productDetail`)

#### Controller Pattern
- **Base Controller**: `lib/controller/base_controller.dart` - Common functionality for loading states and error handling
- **Bindings**: Each screen has a corresponding binding in `lib/controller/binding/`
- **Dependency Injection**: Controllers are injected via bindings when navigating to routes

#### GraphQL Integration
- Configuration handled in external `b2b_graphql_package`
- Platform-specific GraphQL setup in `main.dart`
- Shopify: Uses storefront API
- ToAutomation: Uses custom GraphQL endpoints

### Directory Structure

#### Core Directories
- `lib/view/` - UI screens organized by feature (home, cart, product_detail, etc.)
- `lib/controller/` - GetX controllers for business logic
- `lib/controller/binding/` - Dependency injection bindings
- `lib/common_component/` - Reusable UI components
- `lib/const/` - Constants, themes, and configuration
- `lib/config/` - App configuration and platform settings

#### Important Files
- `lib/main.dart` - App initialization and platform setup
- `lib/routes.dart` - Navigation routes and bindings
- `lib/config/configConstant.dart` - Platform and app configuration
- `pubspec.yaml` - Dependencies and app metadata

## Development Guidelines

### Platform Configuration
- Current platform: Shopify (`platform = 'shopify'`)
- App title: "9shineslabel"
- Website URL: "https://www.9shineslabel.com/"
- Client folder: "vilanbusiness"

### Key Features
- **Multi-platform Support**: Shopify and custom backend
- **E-commerce Features**: Product catalog, cart, checkout, orders, wishlist
- **User Management**: Registration, login, profile, addresses
- **Search & Filtering**: Product search with filters
- **Booking System**: Multi-booking functionality for bulk orders
- **Reviews & Ratings**: Product reviews and ratings
- **Firebase Integration**: Analytics, messaging, authentication
- **Payment Integration**: Razorpay payment gateway
- **Location Services**: Geolocation and geocoding
- **Media Features**: Image handling, video playback, speech-to-text

### Common Development Patterns
- Screen components are wrapped with `ConnectivityWrapper` for offline handling
- Controllers extend `BaseController` for consistent error handling and loading states
- All navigation uses GetX named routes with proper bindings
- GraphQL queries and mutations are handled through the external package
- Platform-specific UI variations controlled by `platform` constant checks

### Dependencies
- **UI**: Material Design with custom theming (light/dark mode support)
- **State Management**: GetX (Get)
- **HTTP**: Dio for REST APIs, GraphQL Flutter for GraphQL
- **Storage**: Get Storage for local data, Shared Preferences for system preferences
- **Media**: Cached Network Image, Image Picker, Video Player
- **Firebase**: Core, Auth, Analytics, Messaging, Notifications
- **Payment**: Razorpay Flutter
- **Location**: Geolocator, Geocoding
- **Other**: HTML parsing, WebView, Share functionality, Speech-to-Text

### Testing
- Basic widget tests available in `test/` directory
- Test individual screens and controllers as needed