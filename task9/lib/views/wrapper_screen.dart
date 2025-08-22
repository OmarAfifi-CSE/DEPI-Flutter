import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task9/styling/app_text_styles.dart';

import '../styling/app_colors.dart';
import '../widgets/logout_dialog.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onPageTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  static const List<String> _pageTitles = [
    'Home',
    'Wishlist',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _pageTitles[navigationShell.currentIndex],
          style: AppTextStyles.primaryHeadlineStyle.copyWith(fontSize: 18),
        ),
        backgroundColor: AppColors.whiteColor,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
        actions: [
          ?navigationShell.currentIndex == 0
              ? IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 24),
                  onPressed: () {
                    _onPageTapped(context, 1);
                  },
                  tooltip: 'Cart',
                )
              : null,
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.whiteColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.blueColor),
              child: Text('Menu', style: AppTextStyles.whiteTextStyle),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined, size: 24),
              title: const Text('Home'),
              onTap: () {
                _onPageTapped(context, 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outline, size: 24),
              title: const Text('Wishlist'),
              onTap: () {
                _onPageTapped(context, 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined, size: 24),
              title: const Text('Cart'),
              onTap: () {
                _onPageTapped(context, 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, size: 24),
              title: const Text('Profile'),
              onTap: () {
                _onPageTapped(context, 3);
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: AppColors.greyColor,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: const Icon(Icons.logout, size: 24, color: Colors.red),
              title: const Text('Log Out'),
              onTap: () {
                LogoutDialog.showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
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
