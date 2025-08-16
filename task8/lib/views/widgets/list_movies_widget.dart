import 'package:flutter/material.dart';

import '../../helpers/app_colors.dart';
import '../../models/movie.dart';
import '../movie_detail_screen.dart';

class ListMoviesWidget extends StatefulWidget {
  const ListMoviesWidget({super.key});

  @override
  State<ListMoviesWidget> createState() => _ListMoviesWidgetState();
}

class _ListMoviesWidgetState extends State<ListMoviesWidget> {
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMovies = Movie.getBookmarkedMovies();
    searchController.addListener(_filterMovies);
  }

  void _filterMovies() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredMovies = Movie.getBookmarkedMovies();
      } else {
        filteredMovies = Movie.getBookmarkedMovies()
            .where(
              (movie) => movie.title.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search watchlist',
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
        ),
        Expanded(
          child: filteredMovies.isEmpty
              ? const Center(
                  child: Text(
                    'No movies in watchlist',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(movie: filteredMovies[index]),
                          ),
                        );
                      },
                      child: Card(
                        color: AppColors.primaryColor,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 45,
                            height: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image: AssetImage(filteredMovies[index].posterUrl),
                                fit: BoxFit.cover,
                              ),
                              color: AppColors.secondaryColor,
                            ),
                            child: filteredMovies[index].posterUrl.isEmpty
                                ? const Icon(
                                    Icons.movie,
                                    color: AppColors.whiteColor,
                                  )
                                : null,
                          ),
                          title: Text(
                            filteredMovies[index].title,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredMovies[index].releaseDate,
                                style: const TextStyle(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    filteredMovies[index].rating.toString(),
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.bookmark,
                              color: AppColors.yellowColor,
                            ),
                            onPressed: () {
                              setState(() {
                                filteredMovies[index].isBookmarked = false;
                                _filterMovies();
                              });
                            },
                          ),
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
