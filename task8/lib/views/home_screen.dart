import 'package:flutter/material.dart';
import 'package:task8/views/widgets/featured_movies_widget.dart';
import 'package:task8/views/widgets/grid_movies_widget.dart';

import '../helpers/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search TextField
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search movies',
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 16.0,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 24,
                    color: AppColors.secondaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6.0,
                  ),
                  fillColor: AppColors.primaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              const SizedBox(height: 28.0),
              // Featured Movies Section - only show when not searching
              if (searchQuery.isEmpty) ...[
                const FeaturedMoviesWidget(),
                const SizedBox(height: 36.0),
              ],
              // All Movies Section
              Text(
                searchQuery.isEmpty ? 'All Movies' : 'Search Results',
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              GridMoviesWidget(searchQuery: searchQuery),
            ],
          ),
        ),
      ),
    );
  }
}
