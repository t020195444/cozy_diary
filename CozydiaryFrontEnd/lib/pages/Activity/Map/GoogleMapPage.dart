import 'dart:async';
import 'package:cozydiary/pages/Activity/Map/LocalActivityList/LocalActivityList_GridView.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityController.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityTabbarController.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class GeolocatorService {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}

class GoogleMapPage extends StatefulWidget {
  @override
  State<GoogleMapPage> createState() => GoogleMapPageState();
}

const kGoogleApiKey = 'AIzaSyCFx2oYtAcaHgrxwBm9H5-oyQNMsVUeh-Y';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController googleMapController;
  final topTabbarController = Get.put(ActivityTabbarController());
  ActivityController postCoverController = Get.put(ActivityController());

  Set<Marker> markersList = Set();

  postcover() async {
    double lat = 0;
    double lng = 0;

    for (int i = 0; i < postCoverController.postCover.length; i++) {
      if (lat != postCoverController.postCover[i].placeLat ||
          lng != postCoverController.postCover[i].placeLng ||
          lat != 0) {
        lat = postCoverController.postCover[i].placeLat;
        lng = postCoverController.postCover[i].placeLng;
        String imgurl = postCoverController.postCover[i].cover;
        markersList.add(Marker(
            onTap: (() => Get.to(
                  LocalActivityList(
                      postCoverController.postCover[i].placeLat.toString(),
                      postCoverController.postCover[i].placeLng.toString()),
                  transition: Transition.fade,
                  duration: Duration(seconds: 1),
                )),
            markerId: MarkerId(i.toString()),
            position: LatLng(lat, lng),
            icon: await MarkerIcon.downloadResizePictureCircle(imgurl,
                size: 150,
                addBorder: true,
                borderColor: Colors.white,
                borderSize: 15
                // BitmapDescriptor.fromBytes(bytes)
                )));
      }
    }
    ;
    print(markersList.toString());
  }

  loadData() async {
    await postCoverController.getPostCover();
    await postcover();
    setState(() {});
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.0419, 121.5256),
    zoom: 14.4746,
  );

  @override
  void initState() {
    GeolocatorService()._determinePosition();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Stack(children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              markers: markersList,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              myLocationEnabled: true,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 135, 110, 95),
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.2, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    loadData();
                  },
                  child: const Text(
                    "找尋活動",
                    style: TextStyle(color: Colors.white),
                  ),
                ))),
      ]),
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    // markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
