import 'package:cozydiary/firebase/google_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  late String id;
  late UserMetadata metadata;

  loginWithGoogle() async {
    googleAccount.value = await googleSignIn.signIn();
    final googleAuth = await googleAccount.value!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    id = googleSignIn.currentUser!.id;
    userId = user!.uid;
  }

  getuserdata() async {
    print(id);
  }
}
