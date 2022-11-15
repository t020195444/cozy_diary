import 'dart:async';
import 'package:cozydiary/pages/Activity/controller/ActivityGetPostController.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

class ShowActivityLocation extends StatefulWidget {
  @override
  State<ShowActivityLocation> createState() => ShowActivityLocationState();
}

const kGoogleApiKey = 'AIzaSyCFx2oYtAcaHgrxwBm9H5-oyQNMsVUeh-Y';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class ShowActivityLocationState extends State<ShowActivityLocation> {
  var getPostCoverController = Get.put(ActivityGetPostController());

  Set<Marker> markersList = Set();

  late GoogleMapController googleMapController;

  late final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(getPostCoverController.activityLat.value.toDouble(),
        getPostCoverController.activityLng.value.toDouble()),
    zoom: 14.4746,
  );

  @override
  void initState() {
    GeolocatorService()._determinePosition();
    markersList.add(Marker(
      markerId: MarkerId(""),
      position: LatLng(getPostCoverController.activityLat.value.toDouble(),
          getPostCoverController.activityLng.value.toDouble()),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
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
    print(lat);
    final lng = detail.result.geometry!.location.lng;
    print(lng);

    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
