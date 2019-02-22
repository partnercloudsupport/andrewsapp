import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  AuthService({
    @required this.firebaseAuth,
  });

  AuthService.instance() : firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth firebaseAuth;

  Future<void> signInWithGoogle(Map formData) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: formData['email'],
      password: formData['password'],
    );
    // final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    // // TODO(abraham): Handle null googleAccount
    // final GoogleSignInAuthentication googleAuth =
    //     await googleAccount.authentication;
    // await firebaseAuth.signInWithGoogle(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
  }
}
