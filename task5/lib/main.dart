import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget squareShape({
    required MaterialColor color,
    required double width,
    required double height,
    bool isRow = false,
  }) {
    if (isRow) {
      final temp = height;
      height = width;
      width = temp;
    }

    final List<Widget> children = [
      Container(width: width, height: height, color: color),
      Container(width: width, height: height, color: color[300]),
      Container(width: width, height: height, color: color[200]),
      Container(width: width, height: height, color: color[100]),
    ];
    return isRow ? Row(children: children) : Column(children: children);
  }

  Widget stairsShape({
    required CrossAxisAlignment crossAxisAlignment,
    required MaterialColor color,
    required double width,
    required double height,
    bool isRow = false,
  }) {
    if (isRow) {
      final temp = height;
      height = width;
      width = temp;
    }
    return isRow
        ? Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Container(width: width, height: height, color: color),
              Container(width: width, height: height * .7, color: color[300]),
              Container(width: width, height: height * .5, color: color[200]),
              Container(width: width, height: height * .3, color: color[100]),
            ],
          )
        : Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Container(width: width, height: height, color: color),
              Container(width: width * .7, height: height, color: color[300]),
              Container(width: width * .5, height: height, color: color[200]),
              Container(width: width * .3, height: height, color: color[100]),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final width = 92.0;
    final height = 22.5;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 3,
          title: Center(
            child: Text(
              'Column & Row',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                squareShape(color: Colors.purple, width: width, height: height),
                squareShape(color: Colors.green, width: width, height: height),
                squareShape(color: Colors.blue, width: width, height: height),
              ],
            ),
            // Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                stairsShape(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  color: Colors.purple,
                  width: width,
                  height: height,
                ),
                stairsShape(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  color: Colors.green,
                  width: width,
                  height: height,
                ),
                stairsShape(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  color: Colors.blue,
                  width: width,
                  height: height,
                ),
              ],
            ),
            // Third Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                stairsShape(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  color: Colors.purple,
                  width: width,
                  height: height,
                  isRow: true,
                ),
                stairsShape(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  color: Colors.green,
                  width: width,
                  height: height,
                  isRow: true,
                ),
                stairsShape(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  color: Colors.blue,
                  width: width,
                  height: height,
                  isRow: true,
                ),
              ],
            ),
            // Fourth Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                squareShape(
                  color: Colors.purple,
                  width: width,
                  height: height,
                  isRow: true,
                ),
                squareShape(
                  color: Colors.green,
                  width: width,
                  height: height,
                  isRow: true,
                ),
                squareShape(
                  color: Colors.blue,
                  width: width,
                  height: height,
                  isRow: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
