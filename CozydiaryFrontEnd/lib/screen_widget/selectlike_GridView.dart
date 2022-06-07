import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Data/dataResourse.dart';
import '../pages/Personal/widget/buildCard_personal.dart';

class SelectLikeGridView extends StatelessWidget {
  const SelectLikeGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MasonryGridView.count(
            crossAxisCount: 3,
            itemCount: Image_List.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: BuildCard(
                  index: index,
                  userPostCover: [],
                ),
                onTap: () {},
              );
            }));
  }
}
