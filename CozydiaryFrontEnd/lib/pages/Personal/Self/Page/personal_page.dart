import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Personal/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../TrackerPage/Page/trackerAndFollowerPage.dart';
import '../controller/selfController.dart';
import '../controller/tabbarController.dart';
import '../widget/self_CollectGridView.dart';
import '../widget/self_PostGridView.dart';

import 'package:expandable/expandable.dart';

import 'edit_Personal.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return PersonalView(uid: this.uid);
  }
}

class PersonalView extends StatelessWidget {
  const PersonalView({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    //tabBar的控制器
    final _tabController = Get.put(TabbarController());
    final selfController = Get.find<SelfPageController>();
    // selfController.onInit();

    //使用者頭貼照片
    Widget _buildSliverHeaderWidget() {
      return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverHeaderDelegate(
            MediaQuery.of(context).size.height * 0.5, 70, selfController),
      );
    }

    //Tabbar
    Widget _buildTabbarWidget(var controller, var tab) {
      return SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: _TabbarDelegate(
            TabBar(
                controller: controller,
                indicatorWeight: 2,
                // indicatorColor: Color.fromARGB(255, 175, 152, 100),
                // labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 40),
                tabs: tab),
          ));
    }

    Widget _DetailSliverWidget() {
      return SliverToBoxAdapter(
        child: Column(
          children: <Widget>[
            Divider(
              // color: Colors.black54,
              indent: 40,
              endIndent: 40,
              height: 3,
            ),
            Obx(
              () => ExpandableNotifier(
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
                          selfController.userData.value.introduction,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded:
                            Text(selfController.userData.value.introduction),
                        builder: (_, collapsed, expanded) => Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      );
    }

    return Obx(
      () =>
          // selfController.isLoading.value
          //     ? SpinKitFadingCircle(
          //         size: 50,
          //         color: Colors.black,
          //       )
          //     :
          Scaffold(
        key: GlobalKey<RefreshIndicatorState>(),
        extendBodyBehindAppBar: true,
        drawer: DrawerWidget(
          userImageUrl: selfController.userData.value.picResize,
          userName: selfController.userData.value.name,
          uid: selfController.uid,
        ),
        body: RefreshIndicator(
          notificationPredicate: ((notification) {
            return true;
          }),
          onRefresh: (() async {
            await selfController.getUserData();
            await selfController.getUserPostCover(uid);
          }),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  _buildSliverHeaderWidget(),
                  _DetailSliverWidget(),
                  _buildTabbarWidget(
                      _tabController.controller, _tabController.tabs)
                ];
              },
              body: TabBarView(
                controller: _tabController.controller,
                children: [
                  Obx(() => selfController.postCover.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Expanded(
                                child: Icon(Icons.image_rounded,
                                    size:
                                        MediaQuery.of(context).size.width * 0.3,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "你尚未發文章喔~\n快點分享你的生活吧！",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ))
                      : InitPostGridView()),
                  Obx(() => selfController.postCover.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Expanded(
                                child: Icon(Icons.image_rounded,
                                    size:
                                        MediaQuery.of(context).size.width * 0.3,
                                    color: Theme.of(context).iconTheme.color),
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
                      : InitCollectGridView())
                ],
              )),
        ),
      ),
    );
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
      // color: Colors.white,
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
  _SliverHeaderDelegate(
    this.expandedHeight,
    this.tabbarHeight,
    this._selfPageController,
  );

  final double expandedHeight;
  final double tabbarHeight;
  final SelfPageController _selfPageController;

  @override
  double get minExtent => 0;
  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        Obx(() => _selfPageController.userData.value.pic != ""
            ? Image.network(_selfPageController.userData.value.pic,
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
              )),
        Container(
          color: Color.fromARGB(100, 0, 0, 0),
          height: expandedHeight,
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("登出"),
                      onTap: () => Get.find<LoginController>().logout(),
                    )
                  ],
                  child: Icon(Icons.more_horiz_outlined, color: Colors.white),
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
                child: Obx(() => followerWidget(
                    _selfPageController.userData.value.tracker.length,
                    _selfPageController.userData.value.follower.length,
                    _selfPageController.postCover.length,
                    0)),
              ),
            )),
        Obx(() => Positioned(
              top: (expandedHeight - tabbarHeight) * 0.8 - shrinkOffset,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selfPageController.userData.value.name,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "UID:" + _selfPageController.userData.value.googleId,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )),
        Positioned(
            top: (expandedHeight - tabbarHeight) * 0.8 - shrinkOffset,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                var status = await Get.to(
                    Edit_PersonalPage(
                        userData: _selfPageController.userData.value),
                    transition: Transition.downToUp);
                if (status == "更新用戶資料成功") {
                  _selfPageController.getUserData();
                }
              },
              child: Text(
                "編輯個人資料",
                // style: TextStyle(color: Colors.black54),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(174, 164, 131, 106),
              ),
            ))
      ],
    );
  }

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
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ]),
          onTap: () {
            Get.to(
              TrackerPage(
                index: 0,
                uid: _selfPageController.uid,
              ),
              // TrackerAndFollowerPage(
              //   uid: _selfPageController.uid,
              //   index: 0,
              // ),
              transition: Transition.rightToLeft,
            );
          },
        ),
        InkWell(
          onTap: (() {
            Get.to(
                TrackerPage(
                    key: UniqueKey(), index: 1, uid: _selfPageController.uid),
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
              style: TextStyle(
                fontSize: 14,
              ),
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
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ]),
        Column(children: <Widget>[
          Text(
            '$eventCount',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Text(
            '活動數',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ]),
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return false;
  }
}
