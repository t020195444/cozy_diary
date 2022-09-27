import 'dart:async';
import 'package:cozydiary/pages/Activity/controller/ActivityTabbarController.dart';
import 'package:cozydiary/pages/Activity/widget/Activity_GridView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class GeolocatorService {
  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var changePage = false;
  late List<Marker> markers;
  late int pointIndex;
  List<LatLng> points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  final topTabbarController = Get.put(ActivityTabbarController());

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double?>();
    pointIndex = 0;
    markers = [
      // Marker(
      //   anchorPos: AnchorPos.align(AnchorAlign.center),
      //   height: 30,
      //   width: 30,
      //   point: points[pointIndex],
      //   builder: (ctx) => const Icon(Icons.pin_drop),
      // ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(25.042202549516646, 121.5259613226078),
        builder: (ctx) => const Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(25.042202549516647, 121.5259613226078),
        builder: (ctx) => const Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(25.042202549516645, 121.5259613226078),
        builder: (ctx) => const Icon(Icons.pin_drop),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          FlutterMap(
            options: MapOptions(
              plugins: [
                LocationMarkerPlugin(),
                MarkerClusterPlugin(),
              ],
              center: LatLng(25.042202549516645, 121.5259613226078),
              zoom: 15,
              maxZoom: 19,

              // Stop centering the location marker on the map if user interacted with the map.
              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture) {
                  setState(
                    () =>
                        _centerOnLocationUpdate = CenterOnLocationUpdate.never,
                  );
                }
              },
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              LocationMarkerLayerOptions(),
              MarkerClusterLayerOptions(
                maxClusterRadius: 120,
                size: Size(40, 40),
                fitBoundsOptions: FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: markers,
                polygonOptions: PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                builder: (context, markers) {
                  return FloatingActionButton(
                    child: Text(markers.length.toString()),
                    onPressed: null,
                  );
                },
              ),
            ],
            // ignore: sort_child_properties_last
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  maxZoom: 19,
                ),
              ),
              LocationMarkerLayerWidget(
                plugin: LocationMarkerPlugin(
                  centerOnLocationUpdate: _centerOnLocationUpdate,
                ),
              ),
            ],
            nonRotatedChildren: [
              Positioned(
                right: 20,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    // Automatically center the location marker on the map when location updated until user interact with the map.
                    setState(
                      () => _centerOnLocationUpdate =
                          CenterOnLocationUpdate.always,
                    );
                    // Center the location marker on the map and zoom the map to level 18.
                    _centerCurrentLocationStreamController.add(18);
                  },
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          ActivityScreen(),
        ],
        controller: topTabbarController.topController,
      ),
    );
  }
}
