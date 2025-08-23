import 'package:go_router/go_router.dart';
import 'package:task9/views/cart_screen.dart';
import 'package:task9/views/wishlist_screen.dart';
import 'package:task9/views/profile_screen.dart';

import '../views/home_screen.dart';
import '../views/signin_screen.dart';
import '../views/wrapper_screen.dart';
import '../views/item_detail_screen.dart';
import '../model/product.dart';
import 'app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter() => GoRouter(
    initialLocation: AppRoutes.wrapperScreen,
    routes: [
      GoRoute(
        path: AppRoutes.signInScreen,
        name: AppRoutes.signInScreen,
        builder: (context, state) => const SigninScreen(),
      ),

      GoRoute(
        path: AppRoutes.itemDetailScreen,
        name: AppRoutes.itemDetailScreen,
        builder: (context, state) {
          // Cast 'extra' to a Map
          final args = state.extra as Map<String, dynamic>;
          final product = args['product'] as Product;
          final prefix = args['prefix'] as String;
          final uniqueTag = '${prefix}_${product.id}';
          return ItemDetailScreen(product: product, heroTag: uniqueTag);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return WrapperScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wrapperScreen,
                name: AppRoutes.wrapperScreen,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wishlistScreen,
                name: AppRoutes.wishlistScreen,
                builder: (context, state) => const WishlistScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cartScreen,
                name: AppRoutes.cartScreen,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileScreen,
                name: AppRoutes.profileScreen,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
