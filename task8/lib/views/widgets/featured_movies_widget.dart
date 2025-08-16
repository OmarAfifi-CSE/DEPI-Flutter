import 'package:flutter/material.dart';

import '../../helpers/app_colors.dart';
import '../../models/movie.dart';
import '../movie_detail_screen.dart';

class FeaturedMoviesWidget extends StatelessWidget {
  const FeaturedMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Movie> featuredMovies = Movie.staticMovies.where((movie) => movie.isFeatured).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Movies',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 360,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 12.0),
            scrollDirection: Axis.horizontal,
            itemCount: featuredMovies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: featuredMovies[index]),
                    ),
                  );
                },
                child: SizedBox(
                  width: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(featuredMovies[index].posterUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        featuredMovies[index].title,
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.yellowColor, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            featuredMovies[index].rating.toString(),
                            style: const TextStyle(color: AppColors.secondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
