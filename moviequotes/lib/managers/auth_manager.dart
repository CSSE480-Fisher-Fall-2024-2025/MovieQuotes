import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static final AuthManager instance = AuthManager._privateConstructor();
  AuthManager._privateConstructor();

  bool get isSignedin => true; // TODO: Don't hardcode this, do real auth.

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
