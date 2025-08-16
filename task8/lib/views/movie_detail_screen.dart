import 'package:flutter/material.dart';
import '../helpers/app_colors.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          movie.title,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage(movie.posterUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              movie.title,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.secondaryColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Release Date: ${movie.releaseDate}',
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.yellowColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  movie.rating.toString(),
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Text(
              movie.description,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16.0,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

