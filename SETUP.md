# Little Lemon Food Ordering App - Setup Guide

## Prerequisites

- Node.js 16+ and npm
- Expo CLI: `npm install -g expo-cli`
- iOS/Android simulator or physical device (for native testing)
- For iOS: macOS with Xcode installed

## Installation

1. **Clone or extract the project**
   ```bash
   cd lemon-app
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

## Running the App

### Option 1: Web Browser (Easiest)
```bash
npm run web
```
This will open the app in your default web browser at `http://localhost:19006`

### Option 2: iOS Simulator (macOS only)
```bash
npm run ios
```

### Option 3: Android Emulator
```bash
npm run android
```

### Option 4: Expo Snack
Visit [expo.snack.dev](https://expo.snack.dev) and upload this project folder

## App Flow

### First Launch
1. **Onboarding Screen** will appear with a 3-page form:
   - Page 1: Enter First Name and Last Name
   - Page 2: Enter Email and Phone Number
   - Page 3: Enter Address and City
   - Click "Complete" to finish onboarding

### Main App
2. **Home Screen** displays:
   - Little Lemon header
   - Hero section with restaurant description and search bar
   - Menu categories bar (Appetizers, Main Courses, Desserts, Beverages)
   - Food menu list with items, descriptions, and prices
   - Profile icon in the top-right corner

3. **Menu Filtering**:
   - Click category buttons to filter menu items
   - Use the search bar to find specific items

4. **Profile Screen**:
   - Click the profile icon (👤) in the header
   - View and edit your information
   - Click "Save Changes" to update your profile
   - Click "Log out" to clear your data and return to onboarding

## Features

✅ **Persistent Data Storage**
- All user information is saved to the device
- Data survives app restarts
- Data is cleared when you log out

✅ **Responsive Design**
- Works on phones, tablets, and web
- Portrait orientation optimized

✅ **Search Functionality**
- Filter menu items by name
- Real-time search updates

✅ **Category Filtering**
- Quickly filter items by type
- Visual feedback for selected category

✅ **User Authentication**
- Onboarding required before accessing the app
- Profile management
- Secure logout functionality

## Troubleshooting

### Port Already in Use
If you get "Port 8081 already in use":
```bash
# Kill the process using the port
lsof -i :8081 | grep LISTEN | awk '{print $2}' | xargs kill -9
```

### Module Not Found Errors
```bash
# Clear cache and reinstall
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Expo Server Issues
```bash
# Run in offline mode
npm start -- --offline
```

### Clear AsyncStorage
To start fresh (clears all saved user data):
1. Delete the app from your device
2. Reinstall it
3. The onboarding screen will appear again

## Deployment

### Building for Production

**Web:**
```bash
npm run build
```

**iOS:**
```bash
expo build:ios
```

**Android:**
```bash
expo build:android
```

## Development

### Adding New Features
1. Create new screen files in `app/screens/`
2. Update `app/navigation/Navigation.js` to add new routes
3. Use the `UserContext` hook for state management

### Code Structure
```
app/
├── context/UserContext.js      # User data and persistence
├── navigation/Navigation.js     # App routing
├── screens/                     # Screen components
│   ├── OnboardingScreen.js     # 3-page form
│   ├── HomeScreen.js           # Main menu
│   └── ProfileScreen.js        # User profile
└── _layout.tsx                 # Root configuration
```

## Testing Checklist

- [ ] Open app - Onboarding screen appears
- [ ] Fill onboarding form - Next button enabled/disabled correctly
- [ ] Complete onboarding - Navigates to Home screen
- [ ] Home screen loads - All sections visible
- [ ] Search works - Menu items filter correctly
- [ ] Categories filter - Items update when category changes
- [ ] Click profile button - Goes to Profile screen
- [ ] Profile shows data - All onboarding data visible
- [ ] Edit profile - Can change information
- [ ] Save profile - Changes persist
- [ ] Log out - Clears data, returns to onboarding
- [ ] Restart app - Onboarding appears (data cleared)
- [ ] Complete onboarding again - Home screen appears
- [ ] Click profile button - Previous data from second onboarding shown

## Support

For issues or questions about the app structure, refer to `ARCHITECTURE.md`

## License

This is an educational project created for the Little Lemon Food Ordering App assignment.
