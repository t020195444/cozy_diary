// import 'package:cozydiary/pages/Personal/TrackerPage/Controller/trakerController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TrackerPage extends StatelessWidget {
//   final String uid;
//   TrackerPage(this.uid);
//   @override
//   Widget build(BuildContext context) {
//     TrackerController trackerController = Get.find<TrackerController>();
//     // Get.find<TrackerController>();
//     trackerController.getTracker(uid);
//     return ListView.builder(
//       itemCount: trackerController.trackerList.length,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//         child: ListTile(
//           enabled: trackerController.userId ==
//                   trackerController.trackerList.value[index].tracker2
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
//           //         uid: controller.trackerList[index].tracker2,
//           //       );
//           //     })),
//           leading: CircleAvatar(
//             radius: 30,
//             backgroundImage:
//                 NetworkImage(trackerController.trackerList[index].pic),
//           ),
//           title: Text(trackerController.trackerList.value[index].name),
//           trailing: ElevatedButton(
//             child: trackerController.state[index].value
//                 ? Text("取消追蹤")
//                 : Text("追蹤"),
//             onPressed: () {
//               trackerController.tapTracker(
//                   trackerController.trackerList[index].tracker1,
//                   trackerController.trackerList[index].tracker2,
//                   index);
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: trackerController.state[index].value
//                     ? Color.fromARGB(148, 149, 147, 147)
//                     : Color.fromARGB(176, 202, 175, 154),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30))),
//           ),
//         ),
//       ),
//     );
//   }
// }
