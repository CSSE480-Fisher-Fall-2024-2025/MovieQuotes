import 'package:flutter/material.dart';
import 'package:moviequotes/pages/movie_quotes_list_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Don't click the run button due to https images! Do this instead:
// flutter run -d chrome --web-renderer html
// (and then don't forget to hit "r" to reload)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Quotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MovieQuotesListPage(),
      // home: const LoginFrontPage(),
      // home: MovieQuoteDetailPage(
      //   movieQuote: MovieQuote(
      //     quote:
      //         "Hello. My name is Inigo Montoya. You killed my father. Prepare to die.",
      //     movie: "The Princess Bride",
      //   ),
      // ),
    );
  }
}
