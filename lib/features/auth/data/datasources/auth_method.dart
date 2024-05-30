import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/util/snackbar_message.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        // POST to ReqRes API
        bool apiResponse = await postUserToApi(user);
        if (apiResponse) {
          SnackBarMessage.showSuccessSnackBar(message: "Login Successfully and User Posted to API", context: context);
          res = true;
        } else {
          SnackBarMessage.showErrorSnackBar(message: "Login Successful but Failed to Post User to API", context: context);
          res = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      SnackBarMessage.showErrorSnackBar(message: e.message.toString(),context: context);
      res = false;
    }
    return res;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

Future<bool> postUserToApi(User user) async {
  final url = Uri.parse('https://reqres.in/api/users');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': user.displayName,
      'job': 'New User',  // You can adjust this field as needed
    }),
  );

  return response.statusCode == 201;
}
