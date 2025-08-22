import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/app_routes.dart';
import '../styling/app_colors.dart';
import '../styling/app_text_styles.dart';

class LogoutDialog {
  static showLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Confirm Logout',
            style: AppTextStyles.primaryHeadlineStyle.copyWith(fontSize: 20),
          ),
          content: const Text(
            'Are you sure you want to log out of your account?',
            style: AppTextStyles.blackTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.blackTextStyle.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(AppRoutes.signInScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Log Out',
                style: AppTextStyles.buttonTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
