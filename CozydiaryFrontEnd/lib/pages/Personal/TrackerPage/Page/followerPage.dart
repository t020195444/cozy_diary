// import 'package:cozydiary/pages/Personal/TrackerPage/Controller/trakerController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// import '../../OtherPerson/Controller/OtherPersonController.dart';
// import '../../OtherPerson/Page/otherPersonPage.dart';

// class FollowerPage extends StatelessWidget {
//   final String uid;

//   FollowerPage(this.uid);
//   @override
//   Widget build(BuildContext context) {
//     TrackerController followerController = Get.find<TrackerController>();
//     followerController.getFollower(uid);
//     // controller.update();
//     return ListView.builder(
//       itemCount: followerController.trackerList.length,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//         child: ListTile(
//           enabled: followerController.userId ==
//                   followerController.trackerList[index].tracker2
//               ? false
//               : true,
//           // onTap: () => Get.to(GetBuilder<OtherPersonPageController>(
//           //     init: OtherPersonPageController(),
//           //     builder: (otherPersonPageController) {
//           //       otherPersonPageController.otherUid =
//           //           controller.trackerList[index].tracker2;

//           //       otherPersonPageController.getOtherUserData();
//           //       otherPersonPageController.getUserPostCover();
//           //       return OtherPersonalPage(
//           //           uid: controller.trackerList[index].tracker2);
//           //     })),
//           leading: CircleAvatar(
//             radius: 30,
//             backgroundImage:
//                 NetworkImage(followerController.trackerList[index].pic),
//           ),
//           title: Text(followerController.trackerList[index].name),
//           trailing: ElevatedButton(
//             child: Text("移除粉絲"),
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Color.fromARGB(148, 149, 147, 147),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30))),
//           ),
//         ),
//       ),
//     );
//   }
// }
