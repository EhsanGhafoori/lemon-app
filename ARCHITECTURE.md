# Little Lemon Food Ordering App Architecture

## Project Structure

```
app/
├── context/
│   └── UserContext.js          # User state management with AsyncStorage persistence
├── navigation/
│   └── Navigation.js           # Root navigation setup with Stack Navigator
├── screens/
│   ├── OnboardingScreen.js     # 3-page onboarding form
│   ├── HomeScreen.js           # Main app screen with menu
│   └── ProfileScreen.js        # User profile management
└── _layout.tsx                 # Root layout with providers
```

## Key Features

### 1. Onboarding Screen
- **3-page form** with Next/Complete buttons
- Page 1: First Name, Last Name
- Page 2: Email, Phone Number
- Page 3: Address, City
- Data validation on each page
- Button disabled until all required fields are filled

### 2. Home Screen
- **Header** with app title "Little Lemon"
- **Hero Section** featuring:
  - Restaurant name and location (Chicago)
  - Description of the restaurant
  - Search bar for menu filtering
- **Menu Breakdown** section:
  - Horizontal scrollable category buttons
  - Categories: Appetizers, Main Courses, Desserts, Beverages
  - Active category highlighted
- **Food Menu List**:
  - Displays items for selected category
  - Shows item name, description, and price
  - Filters based on search input
- **Profile Button** in header (bottom right icon)

### 3. Profile Screen
- **User Information Display/Edit**:
  - First Name, Last Name
  - Email, Phone Number
  - Address, City
- **Save Changes Button**: Updates and persists user data
- **Log Out Button**: Clears all user data and returns to onboarding
- Back button in header for navigation

## State Management

### UserContext
- **State Variables**:
  - `user`: Current user data object
  - `loading`: Loading state for initial data fetch
  
- **Functions**:
  - `saveUser(userData)`: Persists user data to AsyncStorage and updates state
  - `logout()`: Clears user data from AsyncStorage and state
  - `loadUserData()`: Loads user data from AsyncStorage on app startup

## Navigation Flow

```
┌─────────────────┐
│  App Startup    │
└────────┬────────┘
         │
    Check if user exists
         │
    ┌────┴─────┐
    │           │
   NO          YES
    │           │
    v           v
┌──────────┐  ┌──────────┐
│Onboarding│  │  Home    │
│  Stack   │  │  Stack   │
└──────────┘  └─────┬────┘
              │     │
         ┌────v─────v────┐
         │ Home > Profile │
         │  (Back button) │
         └────────────────┘
```

## Data Persistence

- Uses `@react-native-async-storage/async-storage`
- User data is automatically saved after onboarding
- Data persists across app restarts
- Logout clears all stored user data

## Colors & Styling

- Primary Color: `#495E57` (Dark Green)
- Accent Color: `#F4CE14` (Yellow)
- Secondary Color: `#EE9972` (Orange)
- Background: White (`#fff`)

## Running the App

### Web
```bash
npm run web
```

### iOS
```bash
npm run ios
# (Requires macOS)
```

### Android
```bash
npm run android
```

### Expo Snack (In-Browser)
Can be tested in Expo Snack by uploading this project

## Requirements Met

✅ Onboarding screen with 3 pages and Next button
✅ Home screen with hero section, search bar, and menu
✅ Menu categories with filtering
✅ Food menu list display
✅ Profile screen with user data management
✅ Save/logout functionality
✅ Data persistence across app restarts
✅ Stack navigation with back button
✅ Header with profile access

## Testing Checklist

- [ ] Onboarding: Can complete all 3 pages
- [ ] Onboarding: Data saved correctly
- [ ] Home: Hero section displays correctly
- [ ] Home: Search filters menu items
- [ ] Home: Category buttons work
- [ ] Home: Profile button navigates to Profile screen
- [ ] Profile: Shows saved onboarding data
- [ ] Profile: Can edit and save changes
- [ ] Profile: Log out clears data and returns to onboarding
- [ ] Data persistence: Restart app and verify data is still there
- [ ] Navigation: Back button works from Profile to Home
