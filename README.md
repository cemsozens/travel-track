# 🌍 Travel Map Flutter App

A beautiful, interactive travel map app built with Flutter that helps you track visited countries and plan future travels.

## ✨ Features

- **Interactive World Map**: High-quality world map with country-level interaction
- **Visual Travel Tracking**: 
  - Green countries = Visited
  - Orange countries = Wishlist
  - Gray countries = Not visited
- **Travel Statistics**: Beautiful stats dashboard showing your travel progress
- **Country Lists**: Organized tabs for visited countries and wishlist
- **Data Persistence**: Your travel data is saved locally
- **Material 3 Design**: Modern, beautiful UI with light/dark theme support
- **Responsive Design**: Works on all screen sizes

## 🚀 Installation

### Prerequisites

1. **Install Flutter** (if not already installed):
   - Open VS Code
   - Install the Flutter extension
   - Use Command Palette (Cmd+Shift+P) → "Flutter: New Project" → "Download SDK"
   - Choose installation location (e.g., ~/development/)
   - Add Flutter to PATH when prompted

2. **Verify Flutter Installation**:
   ```bash
   flutter doctor
   ```

### Setup the Project

1. **Navigate to the project directory**:
   ```bash
   cd flutter_travel_map
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## 🎯 How to Use

1. **Mark Countries as Visited**:
   - Tap any country on the map
   - Select "Mark as Visited" from the popup
   - The country will turn green

2. **Add to Wishlist**:
   - Tap any country on the map
   - Select "Add to Wishlist" from the popup
   - The country will turn orange

3. **View Travel Statistics**:
   - Your stats are displayed at the top of the app
   - Shows visited count, wishlist count, and world exploration percentage

4. **Manage Country Lists**:
   - Tap the list icon in the app bar
   - Switch between "Visited" and "Wishlist" tabs
   - Remove countries using the minus icon

## 📱 Screenshots

### Main Screen
- Interactive world map with beautiful colors
- Travel statistics card
- Legend showing country status

### Country Details
- Tap any country to see options
- Mark as visited or add to wishlist
- Clean, intuitive interface

### Country Lists
- Organized tabs for visited and wishlist
- Shows visit dates for visited countries
- Easy removal of countries

## 🛠 Technical Details

### Architecture
- **State Management**: Provider pattern
- **Local Storage**: SharedPreferences for data persistence
- **UI Framework**: Material 3 design system
- **Map Library**: countries_world_map package

### Key Packages
- `countries_world_map`: Interactive world map widget
- `provider`: State management
- `shared_preferences`: Local data storage
- `material_color_utilities`: Material 3 colors

### File Structure
```
lib/
├── main.dart                 # App entry point
├── models/
│   └── country_model.dart    # Country data model
├── providers/
│   └── travel_provider.dart  # State management
├── screens/
│   └── home_screen.dart      # Main app screen
└── widgets/
    ├── travel_stats_card.dart    # Statistics display
    └── country_list_sheet.dart   # Country lists modal
```

## 🎨 Customization

### Colors
You can customize the country colors in `travel_provider.dart`:
```dart
Color getCountryColor(String countryCode) {
  if (isCountryVisited(countryCode)) {
    return Colors.green.shade400;  // Visited color
  } else if (isCountryInWishlist(countryCode)) {
    return Colors.orange.shade400; // Wishlist color
  } else {
    return Colors.grey.shade300;   // Default color
  }
}
```

### Theme
The app supports both light and dark themes automatically based on system settings. You can modify the theme in `main.dart`.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🌟 Features Roadmap

- [ ] Country search functionality
- [ ] Trip planning with routes
- [ ] Photo attachments for visited countries
- [ ] Travel journal entries
- [ ] Statistics export
- [ ] Social sharing
- [ ] Multiple map styles

## 💡 Tips

- The app automatically saves your data, so you won't lose your progress
- Tap the legend to understand the color coding
- Use the country lists to quickly review your travels
- The progress bar shows your world exploration percentage

Enjoy tracking your travels! 🗺️✈️ 