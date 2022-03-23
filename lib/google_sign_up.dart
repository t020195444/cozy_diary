import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

class GoogleSignUp extends StatelessWidget {
  const GoogleSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GoogleSignInProvider>(
      create: (context) => GoogleSignInProvider(),
    );
  }
}
