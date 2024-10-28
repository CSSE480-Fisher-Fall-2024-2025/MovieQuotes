import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviequotes/managers/auth_manager.dart';
import 'package:moviequotes/managers/user_data_document_manager%20copy.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final displayNameTextEditingController = TextEditingController();
  StreamSubscription? userDataSubscription;

  @override
  void initState() {
    super.initState();
    userDataSubscription = UserDataDocumentManager.instance.startListening(
      documentId: AuthManager.instance.uid,
      observer: () {
        setState(() {
          displayNameTextEditingController.text =
              UserDataDocumentManager.instance.displayName;
          print(
              "TODO: Display the name: ${UserDataDocumentManager.instance.displayName}");
          print(
              "TODO: Display the image: ${UserDataDocumentManager.instance.imageUrl}");
        });
      },
    );
  }

  @override
  void dispose() {
    displayNameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
