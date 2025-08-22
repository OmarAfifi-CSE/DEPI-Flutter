import 'package:flutter/material.dart';

import '../model/product.dart';
import '../styling/app_assets.dart';

class ProductController extends ChangeNotifier {
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Textured Camp Collar Shirt',
      description:
          'A modern classic. This all-black shirt features a unique tactile fabric and a relaxed camp collar for effortless smart-casual style.',
      price: 49.99,
      rating: 4.5,
      imageUrl: AppAssets.product1,
      category: 'New',
    ),
    Product(
      id: '2',
      name: 'Structured Knit Polo Shirt',
      description:
          'Crafted from a premium textured knit, this ecru polo shirt offers a sophisticated update to a timeless essential. Perfect for any smart-casual look.',
      price: 59.99,
      rating: 4.6,
      imageUrl: AppAssets.product2,
      category: 'Featured',
    ),
    Product(
      id: '3',
      name: 'Faded Black Wide-Leg Jeans',
      description:
          'Cut from rigid 100% cotton, these wide-leg jeans feature a faded black wash for an authentic vintage feel and a fashion-forward silhouette.',
      price: 79.99,
      rating: 4.3,
      imageUrl: AppAssets.product3,
      category: 'New',
    ),
    Product(
      id: '4',
      name: 'Vintage Wash Straight Fit Jeans',
      description:
          'A timeless staple. These straight-fit jeans in a vintage grey wash are made from durable cotton for a comfortable, lived-in feel.',
      price: 69.99,
      rating: 4,
      imageUrl: AppAssets.product4,
      category: 'Featured',
    ),
    Product(
      id: '5',
      name: 'Wave Graphic Platform Sneakers',
      description:
          'Make a statement with these platform sneakers. Featuring a bold wave graphic and a chunky sole for a modern, elevated look.',
      price: 89.99,
      rating: 4.8,
      imageUrl: AppAssets.product5,
      category: 'New',
    ),
    Product(
      id: '6',
      name: 'Minimalist Court Sneakers',
      description:
          'The perfect everyday sneaker. A clean, minimalist design in smooth white with a tan contrast heel for a touch of classic, versatile style.',
      price: 89.99,
      rating: 4.7,
      imageUrl: AppAssets.product6,
      category: 'Featured',
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
