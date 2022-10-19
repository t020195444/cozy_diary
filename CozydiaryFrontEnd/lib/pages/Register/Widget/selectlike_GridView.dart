import 'dart:ui';

import 'package:flutter/material.dart';

class SelectLikeGridView extends StatelessWidget {
  const SelectLikeGridView({Key? key}) : super(key: key);

  Widget ThemeCard(String assetsUrl, String categoryName) {
    return Container(
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: 0.5, sigmaY: 0.5, tileMode: TileMode.decal),
            child: Image.asset(
              assetsUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(148, 45, 45, 45),
                    Color.fromARGB(28, 77, 75, 75)
                  ]),
              border: Border.all(width: 0.2, color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              "$categoryName",
              style: TextStyle(
                  color: Color.fromRGBO(231, 231, 231, 1), fontSize: 24),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categoryImageList = ["assets/category/workout.jpg"];
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 15,
              crossAxisSpacing: 8),
          itemCount: 8,
          itemBuilder: (context, index) {
            return ThemeCard(categoryImageList[0], "健身");
          },
        ));
  }
}
