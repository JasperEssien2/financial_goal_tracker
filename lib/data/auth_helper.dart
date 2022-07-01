import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  //TODO: Insert Web client ID
  static const webClientId = "";

  static Future<Map<String, String>?> authenticate() async {
    final googleSignin = GoogleSignIn(
      clientId: null,
      // //TODO: Insert scopes
      scopes: [],
    );

    try {
      final auth = await googleSignin.signIn();

      if (auth == null) {
        return null;
      } else {
        final headers = await auth.authHeaders;

        return headers;
      }
    } catch (e) {
      debugPrint("AN ERROR OCCURRED ======== $e");
    }
    return null;
  }
}
