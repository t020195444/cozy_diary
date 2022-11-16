import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Personal/TrackerPage/Page/trackerPage.dart';
import 'package:cozydiary/pages/Personal/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/selfController.dart';
import '../controller/tabbarController.dart';
import '../widget/self_CollectGridView.dart';
import '../widget/self_PostGridView.dart';
import 'edit_Personal.dart';
import 'package:expandable/expandable.dart';

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
    final selfController = Get.put(SelfPageController());
    selfController.onInit();

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
                indicatorColor: Color.fromARGB(255, 175, 152, 100),
                labelColor: Colors.black,
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
              color: Colors.black54,
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
          ],
        ),
      );
    }

    return Scaffold(
      key: GlobalKey<RefreshIndicatorState>(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
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
                Obx(() => _DetailSliverWidget()),
                _buildTabbarWidget(
                    _tabController.controller, _tabController.tabs)
              ];
            },
            body: TabBarView(
              controller: _tabController.controller,
              children: [
                Obx(() => selfController.postCover.isEmpty
                    ? Center(
                        child: Container(
                        child: Icon(
                          Icons.image_rounded,
                        ),
                      ))
                    : InitPostGridView()),
                InitCollectGridView()
              ],
            )),
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
      color: Colors.white,
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
    return Obx(() => Stack(
          children: <Widget>[
            _selfPageController.userData.value.pic != ""
                ? Image.network(
                    _selfPageController.userData.value.pic,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: expandedHeight,
                    errorBuilder: (context, error, stackTrace) =>
                        Text("pic Network Error"),
                  )
                : Image.asset(
                    "assets/images/yunhan.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: expandedHeight,
                    errorBuilder: (context, error, stackTrace) =>
                        Text("pic Network Error"),
                  ),
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
                      child:
                          Icon(Icons.more_horiz_outlined, color: Colors.white),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    child: followerWidget(
                        _selfPageController.userData.value.tracker.length,
                        _selfPageController.userData.value.follower.length,
                        _selfPageController.postCover.length,
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
            ),
            Positioned(
                top: (expandedHeight - tabbarHeight) * 0.8 - shrinkOffset,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(Edit_PersonalPage(),
                        transition: Transition.downToUp);
                  },
                  child: Text(
                    "編輯個人資料",
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(176, 202, 175, 154),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ))
          ],
        ));
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
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '追隨中',
              style:
                  TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          onTap: () {
            Get.to(
                TrackerPage(
                  index: 0,
                ),
                fullscreenDialog: true);
          },
        ),
        InkWell(
          onTap: (() {
            Get.to(
                TrackerPage(
                  index: 1,
                ),
                fullscreenDialog: true);
          }),
          child: Column(children: <Widget>[
            Text(
              '$followerCount',
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '粉絲',
              style:
                  TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
        ),
        Column(children: <Widget>[
          Text(
            '$postCount',
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const Text(
            '貼文',
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ]),
        Column(children: <Widget>[
          Text(
            '$eventCount',
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const Text(
            '活動數',
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
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
