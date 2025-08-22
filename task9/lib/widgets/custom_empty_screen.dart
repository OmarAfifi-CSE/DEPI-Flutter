import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../styling/app_colors.dart';
import '../styling/app_text_styles.dart';

class CustomEmptyScreen extends StatelessWidget {
  final String screenName;
  final IconData iconData;

  const CustomEmptyScreen({
    super.key,
    required this.screenName,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.greyColor.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 60,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Your $screenName is Empty',
                style: AppTextStyles.primaryHeadlineStyle.copyWith(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                _getEmptyMessage(screenName),
                style: AppTextStyles.subtitlesStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'Start Shopping',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getEmptyMessage(String screenName) {
    switch (screenName.toLowerCase()) {
      case 'wishlist':
        return 'Discover amazing products and add them to your wishlist to save for later!';
      case 'cart':
        return 'Add some products to your cart to get started with your shopping!';
      default:
        return 'Start exploring our amazing products!';
    }
  }
}
