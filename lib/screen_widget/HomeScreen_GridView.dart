import 'package:cozydiary/widget/buildCard_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../data/dataResourse.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: HomePageImage_List.length,
            itemBuilder: (context, index) {
              return BuildCardHome(index: index);
            }));
  }
}
