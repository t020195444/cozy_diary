import 'dart:io';

import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final double right;
  final double top;
  final double left;
  final double bottom;
  final dynamic image;
  const UserHeader(
      {Key? key,
      required this.left,
      required this.right,
      required this.top,
      required this.bottom,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
      decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.cover),
          border: Border.all(color: Colors.white, width: 2.5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 0)
          ]),
    );
  }
}



// class PhotoBackground extends StatelessWidget {
//   const PhotoBackground({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.asset(
//           'assets/image/photo.jpg',
//           fit: BoxFit.cover,
//           height: double.infinity,
//           width: double.infinity,
//         ),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Theme.of(context).primaryColor.withOpacity(0.3),
//                 Theme.of(context).primaryColor.withOpacity(0.8),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
