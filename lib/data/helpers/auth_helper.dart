import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  //TODO: Insert Web client ID
  static const webClientId = "";

  static Future<Map<String, String>?> authenticate() async {
    final googleSignin = GoogleSignIn(
      clientId: kIsWeb ? webClientId : null,
      scopes: [
        "https://www.googleapis.com/auth/drive",
        "https://www.googleapis.com/auth/spreadsheets"
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
