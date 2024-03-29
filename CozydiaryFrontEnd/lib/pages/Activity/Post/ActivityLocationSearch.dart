// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _startSearchFieldController = TextEditingController();

  final ActivityPostController postController =
      Get.find<ActivityPostController>();

  DetailsResult? startPosition;

  late FocusNode startFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyCFx2oYtAcaHgrxwBm9H5-oyQNMsVUeh-Y';
    googlePlace = GooglePlace(apiKey);
    startFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _startSearchFieldController,
                autofocus: false,
                focusNode: startFocusNode,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    hintText: '搜尋地點',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                    filled: true,
                    // fillColor: Theme.of(context).primaryColor,
                    border: InputBorder.none,
                    suffixIcon: _startSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _startSearchFieldController.clear();
                              });
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    if (value.isNotEmpty) {
                      //places api
                      autoCompleteSearch(value);
                    } else {
                      //clear out the results
                      setState(() {
                        predictions = [];
                        startPosition = null;
                      });
                    }
                  });
                },
              ),
              SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        predictions[index].description.toString(),
                      ),
                      onTap: () async {
                        final placeId = predictions[index].placeId!;
                        final details = await googlePlace.details.get(placeId);

                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    title: const Text('發文中...'),
                                    content: Container(
                                        height: 150,
                                        width: 30,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                  ));

                          startPosition = details.result;
                          _startSearchFieldController.text =
                              details.result!.name!;
                          predictions = [];
                          postController.updateActivityLocation(startPosition);
                          Get.back();
                          Get.back();
                        }
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
