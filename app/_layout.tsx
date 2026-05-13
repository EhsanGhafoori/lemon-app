import { StatusBar } from 'expo-status-bar';
import 'react-native-reanimated';
import 'react-native-gesture-handler';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { UserProvider } from './context/UserContext';
import Navigation from './navigation/Navigation';

export default function RootLayout() {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <UserProvider>
        <Navigation />
        <StatusBar style="auto" />
      </UserProvider>
    </GestureHandlerRootView>
  );
}
