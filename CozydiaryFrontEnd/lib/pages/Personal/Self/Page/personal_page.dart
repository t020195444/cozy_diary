import 'package:cozydiary/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../controller/SelfController.dart';
import '../controller/TabbarController.dart';
import '../widget/Self_CollectGridView.dart';
import '../widget/Self_PostGridView.dart';
import 'Edit_Personal.dart';

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
    final _tabController = Get.put(TabbarController());
    final _introductionKey = GlobalKey();
    late double oldIntroductionHeight = 0.0;
    final personalController = Get.find<SelfPageController>();

    Widget _buildSliverHeaderWidget() {
      return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverHeaderDelegate(
            MediaQuery.of(context).size.height * 0.5, 70, personalController),
      );
    }

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

    double _getWidgetHeight(GlobalKey key) {
      RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        personalController.constraintsHeight.value =
            _getWidgetHeight(_introductionKey) + 18;
      },
    );

    void _refreshHeight() {
      if (personalController.difference == 0.0) {
        personalController.difference =
            _getWidgetHeight(_introductionKey) - oldIntroductionHeight;
        print(personalController.difference);
        personalController.increaseAppbarHeight();
      } else if (personalController.readmore.value) {
        personalController.reduceAppbarHeight();
      } else {
        personalController.increaseAppbarHeight();
      }
    }

    Widget _DetailSliverWidget() {
      return SliverToBoxAdapter(
        child: Container(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width,
              height: personalController.constraintsHeight.value),
          color: Colors.white,
          height: 90,
          child: Column(
            children: <Widget>[
              Divider(
                color: Colors.black54,
                indent: 40,
                endIndent: 40,
                height: 3,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8),
                    alignment: Alignment.centerLeft,
                    child: ReadMoreText(
                      personalController.userData.value.introduction == ""
                          ? "這個人很無聊，什麼都沒有留呢~"
                          : personalController.userData.value.introduction,
                      key: _introductionKey,
                      colorClickableText: Color.fromARGB(255, 120, 118, 118),
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: "更多",
                      trimExpandedText: "減少",
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 65, 65),
                      ),
                      callback: (isExpand) {
                        oldIntroductionHeight =
                            _getWidgetHeight(_introductionKey);
                        personalController.onTabReadmore();
                        WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) => _refreshHeight());
                      },
                    ),
                    // child: Introduction(
                    //     // "BOCAN選貨店《全館限時免運中》誠實賣場 只有全新公司貨營業時間：13:00-23:00//行銷徵才中 詳情請見精選限時//如何選購：小盒子私訊/7-11賣貨便有想要ㄉ鞋子沒在版上可以帶圖/尺寸 小盒子我們🛒《有任何問題或需求歡迎隨時小盒子》lkfgjofdsijglkfdsjglfsdjglkfdsjglkfdj;sh;jsg;ihojlgfdsjhlkfdsgmblfsgnjhjsrogjgfdoihjgfdihjogfdijsafkadjfkdsjfljsdgkdfgkldsgkljglkjgkfjdskgjkldsgjlskdjglkfdss",
                    //     // personalController.userData.value.introduction == ""?
                    //     "這個人很無聊，什麼都沒有留呢~",
                    //     // : personalController.userData.value.introduction,
                    //     3),
                  )),
            ],
          ),
        ),
      );
    }

    Widget followerWidget(
        int trackerCount, int followingCount, int postCount, eventCount) {
      return Wrap(
        spacing: 25,
        children: <Widget>[
          Column(children: <Widget>[
            Text(
              '$followingCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '追隨中',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$trackerCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '粉絲',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$postCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '貼文',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$eventCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '聚集數',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
        ],
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body:
          // CustomScrollView(
          //   slivers: [
          //     SliverPersistentHeaderWidget(
          //         _tabController.controller, _tabController.tabs),
          //   ],
          // )
          NestedScrollView(
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
                  Obx(() => personalController.postCover.value.isEmpty
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
    this._personalPageController,
  );

  final double expandedHeight;
  final double tabbarHeight;
  final SelfPageController _personalPageController;

  @override
  double get minExtent => 0;
  @override
  double get maxExtent => expandedHeight;

  @override
  final loginController = Get.find<LoginController>();
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget followerWidget(
        int trackerCount, int followerCount, int postCount, eventCount) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: <Widget>[
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
          Column(children: <Widget>[
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
              style:
                  TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
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
              '聚集數',
              style:
                  TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
        ],
      );
    }

    return Obx(() => Stack(
          children: <Widget>[
            _personalPageController.userData.value.pic == null
                ? Image.network(
                    _personalPageController.userData.value.pic,
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
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () {
                        loginController.logout();
                      },
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
                        _personalPageController.userData.value.tracker.length,
                        _personalPageController.userData.value.follower.length,
                        _personalPageController.postCover.value.length,
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
                    _personalPageController.userData.value.name,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "UID:" + _personalPageController.userData.value.googleId,
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
                  child: Text("編輯個人資料"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(176, 202, 175, 154),
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
