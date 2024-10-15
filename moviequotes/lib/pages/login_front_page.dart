import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviequotes/components/square_button.dart';
import 'package:moviequotes/pages/email_password_auth_page.dart';

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const EmailPasswordAuthPage(isNewUser: false),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account yet?"),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const EmailPasswordAuthPage(isNewUser: true),
                    ),
                  );
                },
                child: const Text("Sign Up Here"),
              ),
            ],
          ),
          const SizedBox(
            height: 60.0,
          ),
          ElevatedButton(
            onPressed: () {
              print("TODO: Show the Firebase Auth UI");
            },
            child: const Text("Or sign in with Google"),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
