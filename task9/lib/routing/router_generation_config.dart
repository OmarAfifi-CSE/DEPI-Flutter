import 'package:go_router/go_router.dart';
import 'package:task9/views/cart_screen.dart';

import '../views/home_screen.dart';
import '../views/signin_screen.dart';
import '../views/wrapper_screen.dart';
import '../views/item_detail_screen.dart';
import '../model/product.dart';
import 'app_routes.dart';
class RouterGenerationConfig {
  static GoRouter goRouter() => GoRouter(
    initialLocation: AppRoutes.signInScreen,
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
          final product = state.extra as Product;
          return ItemDetailScreen(product: product);
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
                path: AppRoutes.cartScreen,
                name: AppRoutes.cartScreen,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
