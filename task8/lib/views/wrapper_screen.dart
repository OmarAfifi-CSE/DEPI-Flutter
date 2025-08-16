import 'package:flutter/material.dart';
import 'package:task8/views/watchlist_screen.dart';

import '../helpers/app_colors.dart';
import 'home_screen.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  final PageController _pageController = PageController();
  int _currentScreen = 0;
  final List<Widget> _screens = [const HomeScreen(), const WatchlistScreen()];
  final List<String> _titles = ['Movie Catalog', 'Watchlist'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(_titles[_currentScreen]),
        titleTextStyle: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          _currentScreen == 1
              ? IconButton(
                  icon: const Icon(Icons.search),
                  color: AppColors.whiteColor,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {},
                )
              : Container(),
        ],
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentScreen = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.secondaryColor,
        backgroundColor: AppColors.primaryColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
        ],
        currentIndex: _currentScreen,
        onTap: (index) {
          setState(() {
            _currentScreen = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
