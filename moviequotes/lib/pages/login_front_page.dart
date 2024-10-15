import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviequotes/components/square_button.dart';

class LoginFrontPage extends StatefulWidget {
  const LoginFrontPage({super.key});

  @override
  State<LoginFrontPage> createState() => _LoginFrontPageState();
}

class _LoginFrontPageState extends State<LoginFrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                "Movie Quotes",
                style: TextStyle(
                  fontFamily: "Rowdies",
                  fontSize: 56.0,
                ),
              ),
            ),
          ),
          SquareButton(
              displayText: "Log in",
              onPressCallback: () {
                print("Login Page: pressed button");
              })
        ],
      ),
    );
  }
}
