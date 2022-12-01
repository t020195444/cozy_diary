import 'package:cozydiary/pages/Personal/OtherPerson/Widget/otherPerson_PostGridView.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../TrackerPage/Page/trackerAndFollowerPage.dart';
import '../Controller/otherPersonController.dart';
import '../Controller/otherPersonTabbarController.dart';
import '../Widget/otherPerson_CollectGridView.dart';

class OtherPersonalPage extends StatelessWidget {
  const OtherPersonalPage({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context) {
    Get.put(OtherPersonPageController(otherUid: uid), tag: uid);
    return PersonalView(
      uid: uid,
    );
  }
}

class PersonalView extends StatelessWidget {
  PersonalView({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    var otherPersonPageController =
        Get.find<OtherPersonPageController>(tag: uid);
    final _tabController = Get.put(OtherPersonTabController());

    Widget _buildSliverHeaderWidget() {
      return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverHeaderDelegate(
            MediaQuery.of(context).size.height * 0.5, 70, uid),
      );
    }

    Widget _buildTabbarWidget(var controller, var tab) {
      return SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: _TabbarDelegate(TabBar(
              controller: controller,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 40),
              tabs: tab)));
    }

    Widget _DetailSliverWidget() {
      return SliverToBoxAdapter(
        child: Column(
          children: <Widget>[
            Divider(
              indent: 40,
              endIndent: 40,
              height: 3,
            ),
            ExpandableNotifier(
              child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: ExpandableButton(
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        hasIcon: false,
                      ),
                      collapsed: Text(
                        otherPersonPageController.userData.value.introduction,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Text(otherPersonPageController
                          .userData.value.introduction),
                      builder: (_, collapsed, expanded) => Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      );
    }

    return Obx((() => otherPersonPageController.isLoading.value
        ? SpinKitFadingCircle(
            size: 50,
            color: Colors.black,
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            body: RefreshIndicator(
              notificationPredicate: ((notification) {
                return true;
              }),
              onRefresh: (() async {
                otherPersonPageController.getOtherUserData();
                otherPersonPageController.getUserPostCover();
              }),
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      _buildSliverHeaderWidget(),
                      Obx(() => _DetailSliverWidget()),
                      _buildTabbarWidget(
                          _tabController.controller, _tabController.tabs)
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController.controller,
                    children: [
                      Obx(() => otherPersonPageController.postCover.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Opacity(
                                  opacity: 0.5,
                                  child: Expanded(
                                    child: Icon(Icons.image_rounded,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "此人目前無貼文",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ))
                          : InitOtherPersonPostGridView()),
                      otherPersonPageController.postCover.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Opacity(
                                  opacity: 0.5,
                                  child: Expanded(
                                    child: Icon(Icons.image_rounded,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "尚未收藏貼文",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ))
                          : InitOtherPersonCollectGridView()
                    ],
                  )),
            ),
          )));
  }
}

class _TabbarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tab;

  _TabbarDelegate(
    this.tab,
  );
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Center(child: tab),
    );
  }

  @override
  double get maxExtent => tab.preferredSize.height;

  @override
  double get minExtent => tab.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderDelegate(this.expandedHeight, this.tabbarHeight, this.uid);

  final double expandedHeight;
  final double tabbarHeight;
  final String uid;

  @override
  double get minExtent => 0;
  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var _otherPersonPageController =
        Get.find<OtherPersonPageController>(tag: uid);
    Widget followerWidget(
        int trackerCount, int followerCount, int postCount, eventCount) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Column(children: <Widget>[
              Text(
                '$trackerCount',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                '追隨中',
              ),
            ]),
            onTap: () {
              Get.to(
                TrackerPage(
                    key: UniqueKey(),
                    uid: _otherPersonPageController.otherUid,
                    index: 0),
                // TrackerAndFollowerPage(
                //   uid: _otherPersonPageController.otherUid,
                //   index: 0,
                // ),
                transition: Transition.rightToLeft,
              );
            },
          ),
          InkWell(
            onTap: (() {
              print(_otherPersonPageController.otherUid);
              Get.to(
                  TrackerPage(
                      uid: _otherPersonPageController.otherUid, index: 1),
                  // TrackerAndFollowerPage(
                  //   uid: _otherPersonPageController.otherUid,
                  //   index: 1,
                  // ),
                  fullscreenDialog: true);
            }),
            child: Column(children: <Widget>[
              Text(
                '$followerCount',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                '粉絲',
              ),
            ]),
          ),
          Column(children: <Widget>[
            Text(
              '$postCount',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              '貼文',
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$eventCount',
            ),
            const Text(
              '聚會',
            ),
          ]),
        ],
      );
    }

    return Obx(() => Stack(
          children: <Widget>[
            _otherPersonPageController.userData.value.pic != ""
                ? Image.network(_otherPersonPageController.userData.value.pic,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: expandedHeight,
                    errorBuilder: (context, error, stackTrace) =>
                        Text("pic Network Error"),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[100],
                          width: MediaQuery.of(context).size.width,
                          height: expandedHeight,
                        ),
                      );
                    })
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[100],
                      width: MediaQuery.of(context).size.width,
                      height: expandedHeight,
                    ),
                  ),
            // : Shimmer.fromColors(
            //     baseColor: Colors.grey[400]!,
            //     highlightColor: Colors.grey[200]!,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: expandedHeight,
            //     ),
            //   ),
            Container(
              color: Color.fromARGB(100, 0, 0, 0),
              height: expandedHeight,
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: expandedHeight - tabbarHeight - shrinkOffset,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: tabbarHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    child: followerWidget(
                        _otherPersonPageController
                            .userData.value.tracker.length,
                        _otherPersonPageController
                            .userData.value.follower.length,
                        _otherPersonPageController.postCover.length,
                        0),
                  ),
                )),
            Positioned(
              top: (expandedHeight - tabbarHeight) * 0.8 - shrinkOffset,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "楊哲倫",
                    _otherPersonPageController.userData.value.name,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "UID:" + _otherPersonPageController.userData.value.googleId,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: (expandedHeight - tabbarHeight) * 0.8 - shrinkOffset,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    _otherPersonPageController.addTracker();
                  },
                  child: _otherPersonPageController.isFollow.value
                      ? Text(
                          "已追蹤",
                        )
                      : Text(
                          "追蹤",
                        ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _otherPersonPageController.isFollow.value
                          ? Color.fromARGB(176, 149, 147, 147)
                          : Color.fromARGB(174, 164, 131, 106),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ))
          ],
        ));
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return false;
  }
}
