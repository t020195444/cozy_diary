import 'package:cozydiary/Data/dataResourse.dart';
import 'package:cozydiary/pages/Personal/controller/PersonalController.dart';
import 'package:cozydiary/pages/Personal/controller/TabbarController.dart';

import 'package:cozydiary/pages/Personal/userIdWidget.dart';
import 'package:cozydiary/pages/Personal/userNameWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../screen_widget/collect_GridView.dart';
import '../../../screen_widget/post_GridView.dart';
import '../DrawerWidget.dart';

import 'Edit_Personal.dart';
import '../followerWidget.dart';
import '../userHeaderWidget.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PersonalView();
  }
}

class PersonalView extends GetView<PersonalPageController> {
  const PersonalView({Key? key}) : super(key: key);

  Widget SliverPersistentHeaderWidget(var controller, var tab) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        TabBar(
            controller: controller,
            indicatorWeight: 2,
            indicatorColor: const Color.fromARGB(255, 129, 37, 37),
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: false,
            tabs: tab),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _tabController = Get.put(TabbarController());
    final _userHeaderKey = GlobalKey();
    final _userNameKey = GlobalKey();
    final _userIdKey = GlobalKey();
    final _introductionKey = GlobalKey();
    final _followerKey = GlobalKey();
    final _dividerKey = GlobalKey();
    final personalController = Get.put(PersonalPageController());
    late double _dynamicTotalHeight = 0;
    final List<double> _childWidgetHeights = [];
    dynamic image = UserHeaderImage != null
        ? FileImage(UserHeaderImage!)
        : NetworkImage(Image_List[3]);

    double _getWidgetHeight(GlobalKey key) {
      RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }

    void _getTotalHeight(_) {
      _dynamicTotalHeight = 0;
      _childWidgetHeights.clear();
      _childWidgetHeights.add(_getWidgetHeight(_userHeaderKey));
      _childWidgetHeights.add(_getWidgetHeight(_userNameKey));
      _childWidgetHeights.add(_getWidgetHeight(_userIdKey));
      _childWidgetHeights.add(_getWidgetHeight(_followerKey));
      _childWidgetHeights.add(_getWidgetHeight(_introductionKey));
      _childWidgetHeights.add(_getWidgetHeight(_dividerKey));

      for (double height in _childWidgetHeights) {
        _dynamicTotalHeight = height + _dynamicTotalHeight;
      }

      _dynamicTotalHeight = _dynamicTotalHeight + kToolbarHeight;

      personalController.getSliverAppbarHeight(_dynamicTotalHeight);
    }

    WidgetsBinding.instance.addPostFrameCallback(_getTotalHeight);

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const DrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              GetBuilder<PersonalPageController>(
                builder: ((personalState) => SliverAppBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      primary: true,
                      actions: [
                        GestureDetector(
                          child: Padding(
                            child: Icon(
                              Icons.settings,
                            ),
                            padding: EdgeInsets.only(right: 15),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Edit_PersonalPage()));
                          },
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.passthrough,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 67, 20, 0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      UserHeader(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        image: image,
                                        key: _userHeaderKey,
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(minHeight: 70),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: UserName(
                                                  key: _userNameKey,
                                                )),
                                            UserId(
                                              key: _userIdKey,
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        key: _dividerKey,
                                        color: Color.fromARGB(132, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                  follower_Widget(
                                    key: _followerKey,
                                  ),

                                  // Padding(
                                  //     padding: EdgeInsets.only(bottom: 20),
                                  //     child:
                                  ReadMoreText(
                                    PersonalValue_Map["Introduction"]!,
                                    key: _introductionKey,
                                    trimLines: 3,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: "更多",
                                    colorClickableText: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        centerTitle: true,
                        collapseMode: CollapseMode.pin,
                      ),
                      expandedHeight: personalState.sliverAppbarHeight.value,
                      floating: false,
                      pinned: true,
                      snap: false,
                      bottom: PreferredSize(
                          preferredSize:
                              Size(MediaQuery.of(context).size.height, 60),
                          child: Text("")),
                    )),
              ),
              SliverPersistentHeaderWidget(
                  _tabController.controller, _tabController.tabs),
            ];
          },
          body: TabBarView(
            controller: _tabController.controller,
            children: const [InitPostGridView(), InitCollectGridView()],
          )),
    );
  }
}
// class CustomScrollWidget extends StatefulWidget {
//   const CustomScrollWidget({Key? key}) : super(key: key);

//   @override
//   State<CustomScrollWidget> createState() => _CustomScrollWidgetState();
// }

// class _CustomScrollWidgetState extends State<CustomScrollWidget>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final _userHeaderKey = GlobalKey();
//   final _userNameKey = GlobalKey();
//   final _userIdKey = GlobalKey();
//   final _introductionKey = GlobalKey();
//   final _followerKey = GlobalKey();
//   final _dividerKey = GlobalKey();
//   final List<double> _childWidgetHeights = [];
//   final personalPageState = Get.put(PersonalPageState());
//   double _dynamicTotalHeight = 0;
//   dynamic image;
//   // double _dynamicTotalHeight = 0;

//   @override
//   void initState() {
//     image = UserHeaderImage != null
//         ? FileImage(UserHeaderImage!)
//         : NetworkImage(Image_List[3]);
//     initTabController();
//     WidgetsBinding.instance!.addPostFrameCallback(_getTotalHeight);
//     super.initState();
//   }

//   double _getWidgetHeight(GlobalKey key) {
//     RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
//     return renderBox.size.height;
//   }

//   void _getTotalHeight(_) {
//     _dynamicTotalHeight = 0;
//     _childWidgetHeights.clear();
//     _childWidgetHeights.add(_getWidgetHeight(_userHeaderKey));
//     _childWidgetHeights.add(_getWidgetHeight(_userNameKey));
//     _childWidgetHeights.add(_getWidgetHeight(_userIdKey));
//     _childWidgetHeights.add(_getWidgetHeight(_followerKey));
//     _childWidgetHeights.add(_getWidgetHeight(_introductionKey));
//     _childWidgetHeights.add(_getWidgetHeight(_dividerKey));

//     for (double height in _childWidgetHeights) {
//       _dynamicTotalHeight = height + _dynamicTotalHeight;
//     }

//     _dynamicTotalHeight = _dynamicTotalHeight + kToolbarHeight;
//     print(_dynamicTotalHeight);

//   }

//   void initTabController() {
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   Widget _initTabBarView() {
//     return TabBarView(
//       controller: _tabController,
//       children: const [InitPostGridView(), InitCollectGridView()],
//     );
//   }

//   // void _initDynamicTotalHeight() {
//   //   _dynamicTotalHeight.value = 0;
//   //   _childWidgetHeights.clear();
//   //   _childWidgetHeights.add(_getWidgetHeight(_userHeaderKey));
//   //   _childWidgetHeights.add(_getWidgetHeight(_userNameKey));
//   //   _childWidgetHeights.add(_getWidgetHeight(_userIdKey));
//   //   _childWidgetHeights.add(_getWidgetHeight(_followerKey));
//   //   _childWidgetHeights.add(_getWidgetHeight(_introductionKey));
//   //   for (double height in _childWidgetHeights) {
//   //     _dynamicTotalHeight.value = height + _dynamicTotalHeight.value;

//   //   }
//   // }

//   // void _rebuildDynamicTotalHeight(bool isExpand) {
//   //   // _initDynamicTotalHeight();
//   //   double changeHeight =
//   //       _getWidgetHeight(_introductionKey) - _childWidgetHeights[4];
//   //   _dynamicTotalHeight.value = _dynamicTotalHeight.value + changeHeight;
//   // }

//   Widget SliverAppBarWidget() {
//     return
//          SliverAppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           primary: true,
//           actions: [
//             GestureDetector(
//               child: Padding(
//                 child: Icon(
//                   Icons.settings,
//                 ),
//                 padding: EdgeInsets.only(right: 15),
//               ),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Edit_PersonalPage()));
//               },
//             )
//           ],
//           flexibleSpace: FlexibleSpaceBar(
//             background: Stack(
//               fit: StackFit.passthrough,
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(20, 67, 20, 0),
//                   child: Column(
//                     children: <Widget>[
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           UserHeader(
//                             left: 0,
//                             right: 0,
//                             bottom: 0,
//                             top: 0,
//                             image: image,
//                             key: _userHeaderKey,
//                           ),
//                           ConstrainedBox(
//                             constraints: const BoxConstraints(minHeight: 70),
//                             child: Column(
//                               children: <Widget>[
//                                 Padding(
//                                     padding: EdgeInsets.only(bottom: 5),
//                                     child: UserName(
//                                       key: _userNameKey,
//                                     )),
//                                 UserId(
//                                   key: _userIdKey,
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             key: _dividerKey,
//                             color: Color.fromARGB(132, 0, 0, 0),
//                           ),
//                         ],
//                       ),
//                       follower_Widget(
//                         key: _followerKey,
//                       ),

//                       // Padding(
//                       //     padding: EdgeInsets.only(bottom: 20),
//                       //     child:
//                       ReadMoreText(
//                         PersonalValue_Map["Introduction"]!,
//                         key: _introductionKey,
//                         trimLines: 3,
//                         trimMode: TrimMode.Line,
//                         trimCollapsedText: "更多",
//                         colorClickableText: Colors.black,
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             centerTitle: true,
//             collapseMode: CollapseMode.pin,
//           ),
//           expandedHeight: PersonalPageState._sliverAppbarHeight,
//           floating: false,
//           pinned: true,
//           snap: false,
//           bottom: PreferredSize(
//               preferredSize: Size(MediaQuery.of(context).size.height, 60),
//               child: Text("")),
//         );

//   }

//   Widget SliverPersistentHeaderWidget() {
//     return SliverPersistentHeader(
//       pinned: true,
//       delegate: _SliverAppBarDelegate(
//         TabBar(
//           controller: _tabController,
//           indicatorWeight: 2,
//           indicatorColor: const Color.fromARGB(255, 129, 37, 37),
//           labelColor: Colors.white,
//           indicatorSize: TabBarIndicatorSize.label,
//           isScrollable: false,
//           tabs: const [
//             Tab(
//               child: Text('筆記'),
//             ),
//             Tab(
//               child: Text('收藏'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       drawer: const DrawerWidget(),
//       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//             SliverAppBarWidget(),
//             SliverPersistentHeaderWidget(),
//           ];
//         },
//         body: _initTabBarView(),
//       ),
//     );
//   }
// }

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 37, 35, 35),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
