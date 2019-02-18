import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final fire = Firestore.instance;
//   final usersRef = Firestore.instance.collection('users');

//   Stream<FirebaseUser> get state => _auth.onAuthStateChanged;

//   Future handleFBSignin(String email, String password) async {
//     return _auth.signInWithEmailAndPassword(email: email, password: password);
//   }

//   Future<bool> _checkUserExists(FirebaseUser user) async {
//     var userDoc = await usersRef.document(user.uid).get();
//     return userDoc.exists;
//   }

//   Future<String> currentUser() async {
//     FirebaseUser user = await FirebaseAuth.instance.currentUser();
//     return user != null ? user.uid : null;
//   }

//   Future<void> _createUser(FirebaseUser user) =>
//       usersRef.document(user.uid).setData({
//         'username': user.displayName,
//         'email': user.email,
//         'imageUrl': user.photoUrl,
//       });

//   Future<DocumentReference> handleUserLoggedIn(FirebaseUser user) {
//     return _checkUserExists(user).then((exists) async {
//       if (!exists) await _createUser(user);
//       return usersRef.document(user.uid);
//     });
//   }

//   void handleSignOut() {
//     _auth.signOut();
//     // _googleSignIn.signOut();
//   }
// }
