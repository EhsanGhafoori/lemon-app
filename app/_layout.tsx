import { StatusBar } from 'expo-status-bar';
import 'react-native-reanimated';
import { UserProvider } from './context/UserContext';
import Navigation from './navigation/Navigation';

export default function RootLayout() {
  return (
    <UserProvider>
      <Navigation />
      <StatusBar style="auto" />
    </UserProvider>
  );
}
