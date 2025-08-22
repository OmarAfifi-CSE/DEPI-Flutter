import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task9/controllers/wishlist_controller.dart';
import 'package:task9/routing/router_generation_config.dart';

import 'controllers/cart_controller.dart';
import 'controllers/product_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => WishlistController()),
      ],
      child: MaterialApp.router(
        title: 'SHOPSMART',
        debugShowCheckedModeBanner: false,
        routerConfig: RouterGenerationConfig.goRouter(),
      ),
    );
  }
}
