import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task9/styling/app_text_styles.dart';

import '../styling/app_colors.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onPageTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  static const List<String> _pageTitles = ['Home', 'Cart'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _pageTitles[navigationShell.currentIndex],
          style: AppTextStyles.primaryHeadlineStyle.copyWith(fontSize: 18),
        ),
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
        leading: navigationShell.currentIndex == 0
            ? IconButton(
                icon: const Icon(Icons.menu, size: 24),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'Open menu',
              )
            : null,
        actions: [
          ?navigationShell.currentIndex == 0
              ? IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 24),
                  onPressed: () {
                    // Implement search functionality here
                  },
                  tooltip: 'Cart',
                )
              : null,
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) {
          _onPageTapped(context, index);
        },
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.blackColor,
        unselectedItemColor: AppColors.secondaryColor,
        iconSize: 24,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
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
        ],
      ),
    );
  }
}
