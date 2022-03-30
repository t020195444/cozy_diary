import 'package:flutter/material.dart';

import '../screen_widget/collect_GridView.dart';
import '../screen_widget/post_GridView.dart';
import '../widget/DrawerWidget.dart';
import '../widget/EditPersonalButton.dart';
import '../widget/IntroductionWidget.dart';
import '../widget/followerWidget.dart';
import '../widget/userHeaderWidget.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollWidget();
  }
}

class CustomScrollWidget extends StatefulWidget {
  const CustomScrollWidget({Key? key}) : super(key: key);

  @override
  State<CustomScrollWidget> createState() => _CustomScrollWidgetState();
}

class _CustomScrollWidgetState extends State<CustomScrollWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    initTabController();
  }

  void initTabController() {
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _initTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: const [InitPostGridView(), InitCollectGridView()],
    );
  }
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Widget SliverAppBarWidget() {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      primary: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: <Widget>[
            PhotoBackground(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 67, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      UserHeader(
                        0,
                        10,
                        0,
                        0,
                      ),
                      UserNameAndId(),
                    ],
                  ),
                  IntroductionWidget(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: follower_Widget(),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 20, 55),
                  child: EditPersoalImformationButton(),
                ))
          ],
        ),
        centerTitle: false,
        collapseMode: CollapseMode.pin,
      ),
      expandedHeight: 350.0,
      floating: false,
      pinned: true,
      snap: false,
      bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 44),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 35, 35),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color.fromARGB(255, 129, 37, 37),
              labelColor: Colors.white,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: false,
              tabs: const [
                Tab(
                  child: Text('筆記'),
                ),
                Tab(
                  child: Text('收藏'),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBarWidget(),
            ];
          },
          body: _initTabBarView(),
        ),
        drawer: const DrawerWidget());
  }
}
