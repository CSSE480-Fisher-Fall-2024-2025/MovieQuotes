import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviequotes/models/user_data.dart';

class UserDataDocumentManager {
  UserData? latestUserData;
  final CollectionReference _ref;

  static final UserDataDocumentManager instance =
      UserDataDocumentManager._privateConstructor();

  UserDataDocumentManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kUserDatasCollectionPath);

  StreamSubscription startListening({
    required String documentId,
    required Function observer,
  }) =>
      _ref.doc(documentId).snapshots().listen(
          (DocumentSnapshot documentSnapshot) {
        latestUserData = UserData.from(documentSnapshot);
        observer();
      }, onError: (error) {
        print("Error listening for Movie Quote $error");
      });

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  Future<void> update({
    required String displayName,
    String? imageUrl,
  }) {
    final updatedFields = {
      kUserDataDisplayName: displayName,
    };
    if (imageUrl != null) {
      updatedFields[kUserDataImageUrl] = imageUrl;
    }
    return _ref
        .doc(latestUserData!.documentId!)
        .update(updatedFields)
        .catchError((error) {
      print("There was an error: $error");
    });
  }

  bool get hasDisplayName =>
      latestUserData != null && latestUserData!.displayName.isNotEmpty;
  bool get hasImageUrl =>
      latestUserData != null && latestUserData!.imageUrl.isNotEmpty;

  String get displayName => latestUserData?.displayName ?? "";
  String get imageUrl => latestUserData?.imageUrl ?? "";

  void clearLatest() {
    latestUserData = null;
  }
}
