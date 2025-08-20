import 'package:flutter/material.dart';

import '../model/product.dart';
import '../styling/app_assets.dart';

class ProductController extends ChangeNotifier {
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Cozy Knit Sweater',
      description: 'A warm and stylish knit sweater perfect for winter.',
      price: 49.99,
      imageUrl: AppAssets.product1,
      category: 'New',
    ),
    Product(
      id: '2',
      name: 'Classic Leather Boots',
      description: 'Durable leather boots for everyday wear.',
      price: 129.99,
      imageUrl: AppAssets.product2,
      category: 'Featured',
    ),
    Product(
      id: '3',
      name: 'Minimalist Backpack',
      description: 'A sleek and functional backpack for daily use.',
      price: 79.99,
      imageUrl: AppAssets.product3,
      category: 'All',
    ),
    Product(
      id: '4',
      name: 'Urban Streetwear Jacket',
      description: 'A trendy jacket that combines style and comfort.',
      price: 89.99,
      imageUrl: AppAssets.product4,
      category: 'Featured',
    ),
    Product(
      id: '5',
      name: 'Vintage Denim Jeans',
      description: 'Classic denim jeans with a vintage wash.',
      price: 59.99,
      imageUrl: AppAssets.product5,
      category: 'All',
    ),
    Product(
      id: '6',
      name: 'Athletic Running Shoes',
      description: 'Lightweight running shoes for optimal performance.',
      price: 99.99,
      imageUrl: AppAssets.product6,
      category: 'New',
    ),
  ];

  List<Product> get products => _allProducts;

  List<Product> _filteredProducts = [];

  List<Product> get filteredProducts => _filteredProducts;

  String _selectedTab = 'All';

  String get selectedTab => _selectedTab;

  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';

  ProductController() {
    _filteredProducts = _allProducts;
    searchController.addListener(() {
      updateSearchQuery(searchController.text);
    });
  }

  void _applyFilters() {
    final query = _searchQuery.toLowerCase();

    _filteredProducts = _allProducts.where((product) {
      final nameMatches = product.name.toLowerCase().contains(query);
      final categoryMatches =
          _selectedTab == 'All' || product.category == _selectedTab;
      return nameMatches && categoryMatches;
    }).toList();
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void updateSelectedTab(String tab) {
    _selectedTab = tab;
    _applyFilters();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
