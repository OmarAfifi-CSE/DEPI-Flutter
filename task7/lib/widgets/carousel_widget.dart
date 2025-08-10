import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220.0,
        initialPage: 0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: false,
        padEnds: false,
      ),
      items: [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/images/carousel_item_$i.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(_getCarouselItemTitle(i)),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }

  String _getCarouselItemTitle(int i) {
    switch (i) {
      case 1:
        return 'Special Offer';
      case 2:
        return 'New Arrivals';
      case 3:
        return 'Breakfast Specials';
      default:
        return 'Food Item';
    }
  }
}
