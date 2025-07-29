import 'package:flutter/material.dart';
import 'package:task6/models/cart_item.dart';
import 'package:task6/models/food_item.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // --- CART LOGIC ---
  void _addToCart(FoodItem foodItem) {
    setState(() {
      for (var item in _cartItems) {
        if (item.title == foodItem.title) {
          item.quantity++;
          return;
        }
      }
      _cartItems.add(
        CartItem(
          title: foodItem.title,
          imagePath: foodItem.imagePath,
          price: foodItem.price,
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('\'${foodItem.title}\' added to cart'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'VIEW',
          textColor: Colors.white,
          onPressed: () {
            _onItemTapped(1);
          },
        ),
      ),
    );
  }

  void _incrementCartItem(CartItem item) {
    setState(() => item.quantity++);
  }

  void _decrementCartItem(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _cartItems.remove(item);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('\'${item.title}\' removed from cart'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green.shade800,
          ),
        );
      }
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onAddToCart: _addToCart),
      CartScreen(
        cartItems: _cartItems,
        onIncrement: _incrementCartItem,
        onDecrement: _decrementCartItem,
      ),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
