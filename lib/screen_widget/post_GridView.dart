import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Data/dataResourse.dart';
import '../Widget/buildCard.dart';

class InitPostGridView extends StatelessWidget {
  const InitPostGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: Image_List.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: BuildCard(index: index),
                onTap: () {},
              );
            }));
  }
}
