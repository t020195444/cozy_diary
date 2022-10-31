import 'dart:async';
import 'package:custom_marker/marker_icon.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityController.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityTabbarController.dart';
import 'package:cozydiary/pages/Activity/widget/activity_GridView.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
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
  final topTabbarController = Get.put(ActivityTabbarController());
  final postCoverController = Get.put(ActivityController());

  final Mode _mode = Mode.overlay;

  Set<Marker> markersList = Set();

  loadData() async {
    double lat = 0;
    double lng = 0;

    for (int i = 0; i < postCoverController.postCover.length; i++) {
      if (lat != postCoverController.postCover[i].placeLat ||
          lng != postCoverController.postCover[i].placeLng) {
        lat = postCoverController.postCover[i].placeLat;
        lng = postCoverController.postCover[i].placeLng;
        String imgurl = postCoverController.postCover[i].cover;
        markersList.add(Marker(
            markerId: const MarkerId("0"),
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
    setState(() {
      //refresh UI
    });
  }

  late GoogleMapController googleMapController;

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Center(
          child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              controller: topTabbarController.topController,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              unselectedLabelColor: Color.fromARGB(150, 255, 255, 255),
              unselectedLabelStyle: TextStyle(fontSize: 13),
              tabs: topTabbarController.topTabs),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Stack(children: [
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
            ElevatedButton(
                onPressed: _handlePressButton,
                child: const Text("Search Places")),
          ]),
          ActivityScreen(),
        ],
        controller: topTabbarController.topController,
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "tw")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
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
    print(lat);
    final lng = detail.result.geometry!.location.lng;
    print(lng);

    // markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
