import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  FlatList,
  Image,
  Platform,
} from 'react-native';

const HomeScreen = ({ navigation }) => {
  const [searchText, setSearchText] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('Appetizers');

  React.useEffect(() => {
    navigation.setOptions({
      headerRight: () => (
        <TouchableOpacity
          onPress={() => navigation.navigate('Profile')}
          style={{ marginRight: 15 }}
        >
          <Text style={{ color: '#fff', fontSize: 18, fontWeight: 'bold' }}>👤</Text>
        </TouchableOpacity>
      ),
    });
  }, [navigation]);

  const categories = ['Appetizers', 'Main Courses', 'Desserts', 'Beverages'];

  const menuItems = {
    Appetizers: [
      { id: '1', name: 'Hummus', price: '$5.99', description: 'Chickpea puree' },
      { id: '2', name: 'Falafel', price: '$6.99', description: 'Fried chickpea balls' },
      { id: '3', name: 'Dolmas', price: '$7.99', description: 'Grape leaf rolls' },
    ],
    'Main Courses': [
      { id: '4', name: 'Grilled Fish', price: '$15.99', description: 'Mediterranean sea bass' },
      { id: '5', name: 'Lamb Chops', price: '$18.99', description: 'Herb-seasoned lamb' },
      { id: '6', name: 'Moussaka', price: '$14.99', description: 'Layered eggplant dish' },
    ],
    Desserts: [
      { id: '7', name: 'Baklava', price: '$4.99', description: 'Honey-soaked pastry' },
      { id: '8', name: 'Mousse', price: '$5.99', description: 'Chocolate mousse' },
    ],
    Beverages: [
      { id: '9', name: 'Lemon Water', price: '$2.99', description: 'Fresh lemon water' },
      { id: '10', name: 'Iced Tea', price: '$3.99', description: 'Herbal iced tea' },
    ],
  };

  const filteredItems = menuItems[selectedCategory].filter(item =>
    item.name.toLowerCase().includes(searchText.toLowerCase())
  );

  const renderMenuItem = ({ item }) => (
    <View style={styles.menuItem}>
      <View style={styles.menuItemInfo}>
        <Text style={styles.menuItemName}>{item.name}</Text>
        <Text style={styles.menuItemDescription}>{item.description}</Text>
      </View>
      <Text style={styles.menuItemPrice}>{item.price}</Text>
    </View>
  );

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Little Lemon</Text>
      </View>

      {/* Hero Section */}
      <View style={styles.hero}>
        <Text style={styles.heroTitle}>Little Lemon</Text>
        <Text style={styles.heroSubtitle}>Chicago</Text>
        <Text style={styles.heroDescription}>
          We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
        </Text>
        <View style={styles.searchContainer}>
          <TextInput
            style={styles.searchInput}
            placeholder="Search menu"
            value={searchText}
            onChangeText={setSearchText}
            placeholderTextColor="#999"
          />
        </View>
      </View>

      {/* Menu Breakdown */}
      <View style={styles.menuBreakdown}>
        <Text style={styles.breakdownTitle}>Order for Delivery</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {categories.map(category => (
            <TouchableOpacity
              key={category}
              style={[
                styles.categoryButton,
                selectedCategory === category && styles.categoryButtonActive,
              ]}
              onPress={() => setSelectedCategory(category)}
            >
              <Text
                style={[
                  styles.categoryText,
                  selectedCategory === category && styles.categoryTextActive,
                ]}
              >
                {category}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Food Menu List */}
      <View style={styles.menuList}>
        <FlatList
          data={filteredItems}
          renderItem={renderMenuItem}
          keyExtractor={item => item.id}
          scrollEnabled={false}
        />
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    backgroundColor: '#495E57',
    padding: 20,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#fff',
  },
  hero: {
    backgroundColor: '#495E57',
    padding: 20,
  },
  heroTitle: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#F4CE14',
    marginBottom: 5,
  },
  heroSubtitle: {
    fontSize: 18,
    color: '#fff',
    marginBottom: 10,
  },
  heroDescription: {
    fontSize: 14,
    color: '#fff',
    marginBottom: 20,
    lineHeight: 20,
  },
  searchContainer: {
    marginTop: 10,
  },
  searchInput: {
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    color: '#333',
  },
  menuBreakdown: {
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  breakdownTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginBottom: 15,
  },
  categoryButton: {
    marginRight: 15,
    paddingHorizontal: 15,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#495E57',
    backgroundColor: '#fff',
  },
  categoryButtonActive: {
    backgroundColor: '#495E57',
  },
  categoryText: {
    color: '#495E57',
    fontWeight: '600',
    fontSize: 14,
  },
  categoryTextActive: {
    color: '#fff',
  },
  menuList: {
    padding: 20,
  },
  menuItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
    paddingBottom: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  menuItemInfo: {
    flex: 1,
    marginRight: 15,
  },
  menuItemName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 5,
  },
  menuItemDescription: {
    fontSize: 14,
    color: '#666',
  },
  menuItemPrice: {
    fontSize: 16,
    fontWeight: '600',
    color: '#495E57',
  },
});

export default HomeScreen;
