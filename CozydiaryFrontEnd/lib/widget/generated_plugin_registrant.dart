import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_database_web/firebase_database_web.dart';
import 'package:geolocator_web/geolocator_web.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:video_player_web/video_player_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins(Registrar registrar) {
  FirebaseAuthWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  FirebaseDatabaseWeb.registerWith(registrar);
  GeolocatorPlugin.registerWith(registrar);
  GoogleSignInPlugin.registerWith(registrar);
  VideoPlayerPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
