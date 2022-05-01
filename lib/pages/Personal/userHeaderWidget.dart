import 'package:flutter/material.dart';
import '../../Data/dataResourse.dart';

Widget UserHeader(double left, double right, double top, double bottom) {
  return Container(
    height: 90,
    width: 90,
    margin: EdgeInsets.fromLTRB(left, top, right, bottom),
    decoration: BoxDecoration(
      image: DecorationImage(
          image: NetworkImage(Image_List[3]), fit: BoxFit.cover),
      border: Border.all(color: Colors.white, width: 1),
      shape: BoxShape.circle,
    ),
  );
}

Widget UserNameAndId() {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 80),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              '股票大師= =',
              style: TextStyle(
                  fontSize: 25.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            sex()
          ],
        ),
        const Text(
          'UID:10846005',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget sex() {
  return Container(
    height: 20,
    width: 20,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromARGB(143, 201, 197, 197),
    ),
    child: const Icon(
      Icons.male_outlined,
      size: 15,
      color: Color.fromARGB(255, 14, 131, 226),
    ),
    transform: Matrix4.translationValues(0, -1, 0),
  );
}

class PhotoBackground extends StatelessWidget {
  const PhotoBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/photo.jpg', fit: BoxFit.fill, height: 430),
        Container(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          width: double.infinity,
        )
      ],
    );
  }
}
