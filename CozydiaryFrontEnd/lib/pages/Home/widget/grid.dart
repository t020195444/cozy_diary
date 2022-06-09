import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cozydiary/pages/Home/widget/finalPage.dart';
import 'package:cozydiary/pages/Home/widget/pick.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MediaGrid extends StatefulWidget {
  @override
  _MediaGridState createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  var firstPic;
  pickController pickControllers = Get.put(pickController());
  static List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;
  static late List<bool> _checked =
      List.generate(_mediaList.length, (_) => false);

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    _mediaList = [];
    lastPage = currentPage;

    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      List<AssetEntity> media =
          await albums[0].getAssetListPaged(size: 60, page: currentPage);

      List<Widget> temp = [];
      for (var asset in media) {
        pickController.allPicPath.add(await asset.file);

        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(ThumbnailSize(500, 500)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (asset.type == AssetType.video)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              return Container();
            },
          ),
        );
      }

      firstPic = temp[0];
      setState(() {
        _mediaList.addAll(temp);
        pickControllers.media.addAll(temp);
        currentPage++;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    List currSplit = [];
    String currMultiSplitName;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pickController.themeColor,
        actions: [
          TextButton(
              onPressed: () {
                if (pickControllers.isMultiPick != true) {
                  //單選
                  pickController.finalPicPath = [];
                  pickController.allPicName = [];
                  pickControllers.singleSelectedPicNum();
                  pickController.singlePic = pickController
                      .allPicPath[pickControllers.index.toInt()]!.path;
                  pickController.finalPicPath.add(pickController.singlePic);

                  currSplit = pickController.singlePic.split('/');
                  pickController.singlePic = currSplit.last;

                  pickController.singlePic =
                      pickController.singlePic.toString().replaceAll("'", "");
                  pickController.finalFirstPicPath = pickController.singlePic;
                  pickController.allPicName.add(pickController.singlePic);

                  //測試
                  // print(pickController.allPicName);
                  // print(pickController.finalFirstPicPath);
                  // print(pickController.finalPicPath);

                  // currSplit = pickController.singlePic.split(' ');
                  // pickController.singlePic = currSplit[1];

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalPage(),
                      ));
                } else {
                  //多選
                  if (pickController.selectedPicPathList.isEmpty != true) {
                    pickController.allPicName = [];
                    pickController.multiPicName = [];
                    pickController.finalPicPath = [];
                    for (var i = 0;
                        i < pickController.selectedPicPathList.length;
                        i++) {
                      pickController.multiPic =
                          pickController.allPicPath[i].toString();
                      pickController.finalPicPath.add(pickController.multiPic);
                      currSplit = pickController.multiPic.split('/');
                      currMultiSplitName = currSplit.last;
                      pickController.allPicName
                          .add(currMultiSplitName.replaceAll("'", ""));

                      // currSplit = pickController.multiPic.split(' ');
                      // pickController.finalPicPath.add(currSplit[1]);
                    }

                    pickController.finalFirstPicPath =
                        pickController.allPicName[0];

                    //測試
                    print(pickController.allPicName);
                    print(pickController.finalFirstPicPath);
                    print(pickController.finalPicPath);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinalPage(),
                        ));
                  } else {
                    Fluttertoast.showToast(
                      msg: '請選擇照片',
                      gravity: ToastGravity.CENTER,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Color.fromARGB(255, 65, 65, 66),
                    );
                  }
                }
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('下一頁'))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Obx(
                () => Container(
                    height: 330,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: pickControllers.isPick != true
                        ? firstPic
                        : pickControllers.media[pickControllers.index.value]),
              ),
              Obx(
                () => Positioned(
                  top: 280,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      pickControllers.multiPick();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: pickControllers.MulitButtonColorCheck == true
                              ? Color.fromARGB(183, 105, 105, 105)
                              : pickController.themeColor),
                      child: Icon(Icons.photo_library_outlined),
                    ),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: GridView.builder(
                  itemCount: _mediaList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => Stack(
                        children: [
                          Container(
                            color: Colors.amber,
                            child: GestureDetector(
                                onTap: () {
                                  //所選得照片顯示在最上方
                                  pickControllers.pick();
                                  pickControllers.index.value = index;
                                  setState(() {
                                    if (pickControllers
                                            .currPicFocusDic.isEmpty ==
                                        true) {
                                      pickControllers.currPicFocusDic[index] =
                                          true;
                                    } else {
                                      pickControllers.currPicFocusDic = {};
                                      pickControllers.currPicFocusDic[index] =
                                          true;
                                    }
                                  });
                                  //多選
                                  if (pickControllers.isMultiPick == true) {
                                    setState(() {
                                      if (_checked[index] == true) {
                                        _checked[index] = false;
                                      } else {
                                        _checked[index] = true;
                                      }
                                    });
                                    pickControllers.currNum =
                                        index; //紀錄當下所選index
                                    pickControllers.selectedPicDic[
                                            index] = //紀錄當下所選index的true/false
                                        _checked[index];
                                    pickControllers
                                        .selectedPicNum(); //依據當下所選index的ture/false來將它加入Dictionary
                                  }
                                },
                                child: _mediaList[index]),
                          ),
                          // pickControllers.currPicFocusDic[index] == true
                          //     ? Container(
                          //         color: Color.fromARGB(120, 255, 255, 255),
                          //       )
                          //     : Container(),
                          Container(
                            child: pickControllers.isMultiPick != true
                                ? null
                                : Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _checked[index] == true
                                              ? _checked[index] = false
                                              : _checked[index] = true;
                                        });
                                        //所選得照片顯示在最上方
                                        pickControllers.pick();
                                        pickControllers.index.value = index;

                                        //多選
                                        pickControllers.currNum =
                                            index; //紀錄當下所選index
                                        pickControllers.selectedPicDic[
                                                index] = //紀錄當下所選index的true/false
                                            _checked[index];
                                        pickControllers
                                            .selectedPicNum(); //依據當下所選index的ture/false來將它加入Dictionary
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(129, 68, 68, 68),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: _checked[index] == true
                                            ? Icon(
                                                Icons.check_circle,
                                                color:
                                                    pickController.themeColor,
                                              )
                                            : null,
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
