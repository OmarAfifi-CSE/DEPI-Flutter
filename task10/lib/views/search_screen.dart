import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task10/widgets/animated_weather_background.dart';
import 'package:task10/widgets/glass_container.dart';

import '../controllers/weather_controller.dart';
import '../styling/weather_theme.dart';

class SearchScreen extends StatefulWidget {
  final WeatherController weatherController;
  final WeatherTheme theme;

  const SearchScreen({
    super.key,
    required this.weatherController,
    required this.theme,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> topCitiesEgypt = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Suez',
    'Al Mansurah',
    'Zagazig',
    'Marsa Matruh',
  ];
  final List<String> topCitiesWorld = [
    'New York',
    'Paris',
    'London',
    'Tokyo',
    'Rome',
    'Dubai',
    'Moscow',
    'Sydney',
    'Singapore',
    'Beijing',
    'Athens',
  ];

  void _onCitySelected(String city) {
    if (city.isNotEmpty) {
      widget.weatherController.updateCity(city);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = widget.weatherController;
    final WeatherTheme theme = widget.theme;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedWeatherBackground(theme: theme),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(context, weatherController, theme),
                  SizedBox(height: 24.h),
                  GlassContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    backgroundColor: theme.containerColor.withValues(
                      alpha: 0.8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current city',
                          style: TextStyle(
                            color: theme.primaryTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Current city chip
                        ActionChip(
                          avatar: Icon(
                            Icons.location_on,
                            color: theme.primaryTextColor,
                            size: 18,
                          ),
                          label: Text('${weatherController.weather?.cityName}'),
                          labelStyle: TextStyle(color: theme.primaryTextColor),
                          backgroundColor: theme.containerColor.withValues(
                            alpha: 0.8,
                          ),
                          onPressed: () => _onCitySelected(
                            weatherController.weather?.cityName ?? '',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlassContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    backgroundColor: theme.containerColor.withValues(
                      alpha: 0.8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top cities',
                          style: TextStyle(
                            color: theme.primaryTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: topCitiesEgypt
                              .map((city) => _buildCityChip(city, theme))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlassContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    backgroundColor: theme.containerColor.withValues(
                      alpha: 0.8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top cities - World',
                          style: TextStyle(
                            color: theme.primaryTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: topCitiesWorld
                              .map((city) => _buildCityChip(city, theme))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    WeatherController weatherController,
    WeatherTheme theme,
  ) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => _onCitySelected(value),
      style: TextStyle(color: theme.primaryTextColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        hintText: 'Search for a city...',
        hintStyle: TextStyle(color: theme.primaryTextColor),
        filled: true,
        fillColor: theme.containerColor.withValues(alpha: 0.8),
        prefixIcon: Icon(
          Icons.search,
          color: theme.primaryTextColor.withValues(alpha: 0.8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        ),
      ),
      cursorColor: theme.primaryTextColor,
    );
  }

  Widget _buildCityChip(String cityName, WeatherTheme theme) {
    return ActionChip(
      label: Text(cityName),
      labelStyle: TextStyle(
        color: theme.primaryTextColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: theme.containerColor.withValues(alpha: 0.8),
      shape: const StadiumBorder(),
      side: BorderSide.none,
      onPressed: () => _onCitySelected(cityName),
    );
  }
}
