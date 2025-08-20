import 'package:flutter/material.dart';
import 'package:task9/routing/router_generation_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ShopSmart',
      debugShowCheckedModeBanner: false,
      routerConfig: RouterGenerationConfig.goRouter(),
    );
  }
}
