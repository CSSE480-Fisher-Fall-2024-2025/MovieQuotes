import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthManager {
  User? _user;
  StreamSubscription<User?>? _subscription;
  final Map<UniqueKey, Function> _loginObservers = {};
  final Map<UniqueKey, Function> _logoutObservers = {};

  static final AuthManager instance = AuthManager._privateConstructor();
  AuthManager._privateConstructor();

  void beginListening() {
    if (_subscription != null) {
      return; // Avoid double subscriptions.
    }
    _subscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      final isLogin = _user == null && user != null;
      final isLogout = _user != null && user == null;
      _user = user;
      if (isLogin) {
        for (Function observer in _loginObservers.values) {
          observer();
        }
      }
      if (isLogout) {
        for (Function observer in _logoutObservers.values) {
          observer();
        }
      }
    });
  }

  // Never be called.
  void endListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  UniqueKey addLoginObserver(Function observer) {
    beginListening(); // Only does something the first time.
    var key = UniqueKey();
    _loginObservers[key] = observer;
    return key;
  }

  UniqueKey addLogoutObserver(Function observer) {
    beginListening(); // Only does something the first time.
    var key = UniqueKey();
    _logoutObservers[key] = observer;
    return key;
  }

  void removeObserver(UniqueKey? key) {
    _loginObservers.remove(key);
    _logoutObservers.remove(key);
  }

  bool get isSignedin => _user != null;

  void signInNewUser({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        _showAuthError(context, "The password provided is too weak.");
      } else if (e.code == "email-already-in-use") {
        _showAuthError(context, "The account already exists for that email.");
      } else {
        _showAuthError(context, e.toString());
      }
    } catch (e) {
      _showAuthError(context, e.toString());
    }
  }

  void loginExistingUser({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        _showAuthError(context, "No user found for that email.");
      } else if (e.code == "wrong-password") {
        _showAuthError(context, "Wrong password provided for that user.");
      } else {
        _showAuthError(context, e.toString());
      }
    } catch (e) {
      _showAuthError(context, e.toString());
    }
  }

  void _showAuthError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 6),
      content: Text(message),
    ));
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
