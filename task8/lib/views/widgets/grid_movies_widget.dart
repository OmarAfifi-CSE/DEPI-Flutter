import 'package:flutter/material.dart';
import 'package:task8/models/movie.dart';

import '../../helpers/app_colors.dart';
import '../movie_detail_screen.dart';

class GridMoviesWidget extends StatefulWidget {
  final String searchQuery;

  const GridMoviesWidget({super.key, this.searchQuery = ''});

  @override
  State<GridMoviesWidget> createState() => _GridMoviesWidgetState();
}

class _GridMoviesWidgetState extends State<GridMoviesWidget> {
  List<Movie> get filteredMovies {
    if (widget.searchQuery.isEmpty) {
      return Movie.staticMovies;
    }
    return Movie.staticMovies
        .where((movie) => movie.title
            .toLowerCase()
            .contains(widget.searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final movies = filteredMovies;

    if (movies.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No movies found',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movie: movies[index]),
              ),
            );
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 173,
                    height: 231.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(movies[index].posterUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      movies[index].isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      size: 24.0,
                    ),
                    color: movies[index].isBookmarked
                        ? AppColors.yellowColor
                        : AppColors.primaryColor,
                    onPressed: () {
                      setState(() {
                        movies[index].isBookmarked = !movies[index].isBookmarked;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                movies[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
