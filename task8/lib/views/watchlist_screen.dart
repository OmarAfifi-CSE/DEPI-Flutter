import 'package:flutter/material.dart';
import 'package:task8/views/widgets/list_movies_widget.dart';

import '../helpers/app_colors.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListMoviesWidget(),
    );
  }
}
