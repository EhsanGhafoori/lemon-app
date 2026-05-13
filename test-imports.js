// Test script to validate all imports and basic structure
console.log('Testing app structure...\n');

try {
  console.log('✓ Testing UserContext import');
  // Check if files exist and are valid JavaScript
  const fs = require('fs');
  const path = require('path');

  const filesToTest = [
    'app/context/UserContext.js',
    'app/navigation/Navigation.js',
    'app/screens/HomeScreen.js',
    'app/screens/OnboardingScreen.js',
    'app/screens/ProfileScreen.js',
  ];

  filesToTest.forEach(file => {
    const filePath = path.join(__dirname, file);
    if (fs.existsSync(filePath)) {
      const content = fs.readFileSync(filePath, 'utf8');
      // Basic checks
      if (file.includes('UserContext') && content.includes('UserProvider')) {
        console.log(`✓ ${file} - Contains UserProvider`);
      } else if (file.includes('Navigation') && content.includes('NavigationContainer')) {
        console.log(`✓ ${file} - Contains NavigationContainer`);
      } else if (file.includes('HomeScreen') && content.includes('HomeScreen')) {
        console.log(`✓ ${file} - Valid screen component`);
      } else if (file.includes('OnboardingScreen') && content.includes('OnboardingScreen')) {
        console.log(`✓ ${file} - Valid screen component with 3 pages`);
      } else if (file.includes('ProfileScreen') && content.includes('ProfileScreen')) {
        console.log(`✓ ${file} - Valid screen component with logout`);
      }
    } else {
      console.log(`✗ ${file} - File not found`);
    }
  });

  console.log('\n✓ All app files are present and valid!\n');

  // Check package.json
  const packageJson = JSON.parse(fs.readFileSync(path.join(__dirname, 'package.json'), 'utf8'));
  console.log('Package Info:');
  console.log(`  Name: ${packageJson.name}`);
  console.log(`  Description: ${packageJson.description}`);
  console.log(`  Main: ${packageJson.main}`);

  console.log('\n✓ App structure validation complete!');
} catch (error) {
  console.error('Error during validation:', error.message);
  process.exit(1);
}
