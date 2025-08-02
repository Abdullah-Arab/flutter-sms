# SMS Commands App - Refactored Architecture

A Flutter application that provides an SMS command generator for various Libyan service providers. The app helps users easily generate and send SMS commands to different banks, telecom companies, and government services.

## 🏗️ Architecture

This project follows a **modular feature-first architecture** with the following structure:

```
lib/
├── core/
│   ├── di/                    # Dependency injection setup
│   ├── routing/               # Auto route configuration
│   └── services/              # Reusable app-wide services
├── features/
│   └── sms_commands/          # SMS Commands feature
│       ├── logic/             # Cubits and business logic
│       ├── models/            # Data models
│       └── presentation/      # UI components
├── l10n/                      # Localization files
└── main.dart
```

## 🛠️ Tech Stack

### State Management

- **flutter_bloc** with **Cubit** for state management
- Simple state classes (no Freezed for now to avoid complexity)

### Dependency Injection

- **get_it** for service and Cubit injection
- All services and Cubits registered at app startup

### Local Storage

- **Hive** for persistent storage
- `LocalStorageService` wrapper for common operations

### Localization

- **flutter_localizations** for Arabic and English support
- ARB files in `l10n/` directory

### Routing

- **auto_route** for route management (configured but not fully implemented yet)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.2 or higher
- Dart SDK

### Installation

1. Clone the repository
2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 📱 Features

### Current Implementation

- ✅ Modular architecture with feature-first structure
- ✅ Dependency injection with get_it
- ✅ State management with flutter_bloc and Cubit
- ✅ Local storage with Hive
- ✅ Localization support (Arabic/English)
- ✅ Category list screen with data loading
- ✅ Service provider selection
- ✅ Dynamic form generation based on JSON configuration

### Planned Features

- 🔄 Auto route implementation
- 🔄 Freezed models for better type safety
- 🔄 Complete navigation flow
- 🔄 Form validation and SMS sending
- 🔄 Settings screen
- 🔄 Theme management

## 📊 Data Flow

```
Config JSON → ConfigService → SmsCommandsCubit → UI Screens
```

1. **Configuration Loading**: App loads service providers from `assets/config.json`
2. **State Management**: Cubit manages the app state and user selections
3. **UI Updates**: BlocBuilder reacts to state changes and updates the UI
4. **Form Generation**: Dynamic forms are generated based on selected actions
5. **SMS Generation**: User inputs are combined with templates to generate SMS messages

## 🏦 Supported Services

### Banking Services

- **Nuran Bank**: Account operations, balance checks, IBAN queries
- **Jumhouria Bank**: MyPlus app services, balance checks, card purchases
- **Yaqeen Bank**: Account updates, IBAN queries
- **National Commercial Bank**: Account statements, balance checks
- **Assaray Bank**: Cash withdrawal bookings, card purchases

### Telecom Services

- **Libya Telecom & Technology (LTT)**: 4G account management, balance recharges

## 🔧 Development

### Code Generation

To generate Freezed models and auto_route files (when implemented):

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Adding New Services

1. Add service configuration to `assets/config.json`
2. Update models if needed
3. Add any new UI components in the presentation layer

### State Management

- Use Cubit for business logic
- Keep UI components simple and focused on presentation
- Inject Cubits directly from get_it

## 📝 License

This project is for educational and development purposes.

## 🤝 Contributing

1. Follow the established architecture patterns
2. Use the existing state management approach
3. Add tests for new features
4. Update documentation as needed
