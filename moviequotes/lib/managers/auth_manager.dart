class AuthManager {
  static final AuthManager instance = AuthManager._privateConstructor();
  AuthManager._privateConstructor();

  bool get isSignedin => false; // TODO: Don't hardcode this, do real auth.
}
