import 'package:cozydiary/firebase/google_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleSignIn = GoogleSignIn();

  loginWithGoogle() async {
    googleAccount.value = await googleSignIn.signIn();
  }
}
