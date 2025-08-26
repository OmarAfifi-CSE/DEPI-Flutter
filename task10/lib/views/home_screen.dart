import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/weather_controller.dart';

import '../models/weather_model.dart';
import '../widgets/daily_forecast_tile.dart';
import '../widgets/glass_container.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/weather_detail_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = context.watch<WeatherController>();
    final weather = weatherController.weather;

    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      body: SafeArea(
        child: weatherController.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : weather == null
            ? _buildEmptyState(context, weatherController)
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSearchBar(context, weatherController),
                      SizedBox(height: 24.h),
                      _buildMainWeatherInfo(context, weather),
                      SizedBox(height: 32.h),
                      _buildWeatherDetails(weather),
                      const SizedBox(height: 20),
                      _buildForecastSection(context, weather),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    WeatherController weatherController,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchBar(context, weatherController),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Search for a city to get started!',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    WeatherController weatherController,
  ) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => weatherController.updateCity(value),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        hintText: 'Search for a city...',
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white.withValues(alpha: 0.6),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildMainWeatherInfo(BuildContext context, Weather weather) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            Text(
              '${weather.cityName}, ${weather.country}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Image.network(
          'https:${weather.iconCode}',
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.cloud_off, color: Colors.white, size: 60),
        ),
        Text(
          "${weather.temperature.round()}°C",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weather.condition,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetails(Weather weather) {
    final lastUpdatedTime = DateFormat(
      'HH:mm',
    ).format(DateTime.parse(weather.lastUpdated));
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherDetailCard(
                icon: Icons.thermostat,
                label: 'Feels like',
                value: '${weather.feelsLike.round()}°',
              ),
              WeatherDetailCard(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '${weather.humidity.round()}%',
              ),
              WeatherDetailCard(
                icon: Icons.wind_power,
                label: 'Wind',
                value: '${weather.windSpeed.round()} km/h',
              ),
            ],
          ),
          const Divider(height: 32, color: Colors.white30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherDetailCard(
                icon: Icons.compress,
                label: 'Pressure',
                value: '${weather.pressure.round()} mb',
              ),
              WeatherDetailCard(
                icon: Icons.update,
                label: 'Last updated',
                value: lastUpdatedTime,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(BuildContext context, Weather weather) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOURLY FORECAST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(height: 24, color: Colors.white30),
          _buildHourlyForecast(weather.hourlyForecasts),
          const Divider(height: 32, color: Colors.white30),
          Text(
            'DAILY FORECAST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildDailyForecast(weather.dailyForecasts),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast(List<HourlyForecast> forecasts) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecasts.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final forecast = forecasts[index];
          return HourlyForecastCard(
            time: forecast.time,
            iconUrl: forecast.iconUrl,
            temperature: '${forecast.temp.round()}°',
          );
        },
      ),
    );
  }

  Widget _buildDailyForecast(List<DailyForecast> forecasts) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecasts.length,
      itemBuilder: (context, index) {
        final forecast = forecasts[index];
        // Format the date string to a readable day name
        final date = DateTime.parse(forecast.day);
        final dayName = index == 0
            ? 'Today'
            : index == 1
            ? 'Tomorrow'
            : DateFormat('EEE').format(date); // e.g., 'Thu'

        return DailyForecastTile(
          day: dayName,
          iconUrl: forecast.iconUrl,
          // Pass URL
          condition: forecast.condition,
          tempHigh: '${forecast.maxTemp.round()}°',
          tempLow: '${forecast.minTemp.round()}°',
        );
      },
    );
  }
}
