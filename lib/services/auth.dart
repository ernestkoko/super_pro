import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FbUser {
  FbUser({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Stream<FbUser> get onAuthStateChanged;

  Future<FbUser> currentUser();

  Future<FbUser> signInWithEmailAndPassword(String email, String password);

  Future<FbUser> createUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  FbUser _userFromFirebase(User user) {
    //return null if the user is null
    if (user == null) {
      return null;
    }
    //return uid if the user is not null
    return FbUser(uid: user.uid);
  }

  @override
  Future<FbUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<FbUser> currentUser() async {
    final user = await _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Stream<FbUser> get onAuthStateChanged => throw UnimplementedError();

  @override
  Future<FbUser> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  //sign out method
  @override
  Future<void> signOut() async {
    //sign out from firebase
    await _firebaseAuth.signOut();
  }
}
