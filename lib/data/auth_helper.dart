import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  //TODO: Insert Web client ID
  static const webClientId =
      "1026825019140-ejape5jk5q8foclfd64ckg5igrq0e81p.apps.googleusercontent.com";

  static Future<Map<String, String>?> authenticate() async {
    final googleSignin = GoogleSignIn(
      clientId: null,
      // //TODO: Insert scopes
      scopes: [
        "https://www.googleapis.com/auth/drive",
        "https://www.googleapis.com/auth/spreadsheets",
      ],
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
