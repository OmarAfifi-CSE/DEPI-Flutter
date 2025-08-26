import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyForecastTile extends StatelessWidget {
  final String day;
  final String iconUrl;
  final String condition;
  final String tempHigh;
  final String tempLow;

  const DailyForecastTile({
    super.key,
    required this.day,
    required this.iconUrl,
    required this.condition,
    required this.tempHigh,
    required this.tempLow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Image.network(
                  'https:$iconUrl',
                  height: 40.w,
                  width: 40.w,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.cloud_off,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Tooltip(
                    message: condition,
                    child: Text(
                      condition,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  tempHigh,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                const SizedBox(width: 12),
                Text(
                  tempLow,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
