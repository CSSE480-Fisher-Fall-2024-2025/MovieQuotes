import 'dart:async';

import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviequotes/components/list_page_drawer.dart';
import 'package:moviequotes/components/movie_quote_form_dialog.dart';
import 'package:moviequotes/components/movie_quote_row.dart';
import 'package:moviequotes/managers/auth_manager.dart';
import 'package:moviequotes/managers/movie_quotes_collection_manager.dart';
import 'package:moviequotes/managers/user_data_document_manager.dart';
import 'package:moviequotes/models/movie_quote.dart';
import 'package:moviequotes/pages/login_front_page.dart';
import 'package:moviequotes/pages/movie_quote_detail_page.dart';
import 'package:moviequotes/pages/profile_page.dart';

class MovieQuotesListPage extends StatefulWidget {
  const MovieQuotesListPage({super.key});

  @override
  State<MovieQuotesListPage> createState() => _MovieQuotesListPageState();
}

class _MovieQuotesListPageState extends State<MovieQuotesListPage> {
  final quoteTextEditingController = TextEditingController();
  final movieTextEditingController = TextEditingController();
  UniqueKey? _loginObserverKey;
  UniqueKey? _logoutObserverKey;
  bool _isShowingAllQuotes = true;

  // Not needed if using Firebase UI Firestore
  // StreamSubscription? movieQuotesSubscription;

  @override
  void initState() {
    super.initState();
    _loginObserverKey = AuthManager.instance.addLoginObserver(() {
      UserDataDocumentManager.instance.maybeAddNewUser();
      setState(() {});
    });
    _logoutObserverKey = AuthManager.instance.addLogoutObserver(() {
      setState(() {
        _isShowingAllQuotes = true;
      });
    });

    // Spike test #2 - Pulling data from the cloud
    // FirebaseFirestore.instance
    //     .collection("MovieQuotes")
    //     .snapshots()
    //     .listen((QuerySnapshot querySnapshot) {
    //   for (final doc in querySnapshot.docs) {
    //     print(doc.id);
    //     print(doc.data());
    //   }
    // });

// Not needed if using Firebase UI Firestore
    // movieQuotesSubscription =
    //     MovieQuotesCollectionManager.instance.startListening(() {
    //   setState(() {});
    // });

    // MovieQuotesCollectionManager.instance.latestMovieQuotes.add(
    //   MovieQuote(
    //     quote: "I'll be back!",
    //     movie: "The Terminator",
    //   ),
    // );
    // MovieQuotesCollectionManager.instance.latestMovieQuotes.add(
    //   MovieQuote(
    //     quote: "Everything is Awesome",
    //     movie: "The Lego Movie",
    //   ),
    // );
    // MovieQuotesCollectionManager.instance.latestMovieQuotes.add(MovieQuote(
    //   quote:
    //       "Hello. My name is Inigo Montoya. You killed my father. Prepare to die.",
    //   movie: "The Princess Bride",
    // ));
  }

  @override
  void dispose() {
    quoteTextEditingController.dispose();
    movieTextEditingController.dispose();
    // Not needed if using Firebase UI Firestore
    // MovieQuotesCollectionManager.instance
    //     .stopListening(movieQuotesSubscription);
    AuthManager.instance.removeObserver(_loginObserverKey);
    AuthManager.instance.removeObserver(_logoutObserverKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var actions = <Widget>[];
    if (!AuthManager.instance.isSignedin) {
      actions = [
        IconButton(
          tooltip: "Log in",
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginFrontPage(),
              ),
            );
            setState(() {});
          },
          icon: const Icon(Icons.login),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Movie Quotes"),
        actions: actions,
      ),
      body: FirestoreListView(
        query: _isShowingAllQuotes
            ? MovieQuotesCollectionManager.instance.allMovieQuotesQuery
            : MovieQuotesCollectionManager.instance.onlyMyMovieQuotesQuery,
        itemBuilder: (context, snapshot) {
          final MovieQuote mq = snapshot.data();
          return MovieQuoteRow(
            movieQuote: mq,
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MovieQuoteDetailPage(documentId: mq.documentId!),
                ),
              );
            },
          );
        },
      ),
      drawer: AuthManager.instance.isSignedin
          ? ListPageDrawer(
              editProfileCallback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              showOnlyMineCallback: () {
                setState(() {
                  _isShowingAllQuotes = false;
                });
              },
              showAllCallback: () {
                setState(() {
                  _isShowingAllQuotes = true;
                });
              },
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (AuthManager.instance.isSignedin) {
            showCreateQuoteDialog();
          } else {
            showLoginRequestDialog();
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void showLoginRequestDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Login Required"),
            content: const Text(
                "You must be signed in to add a quote.  Would you like to sign in now?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginFrontPage(),
                    ),
                  );
                  setState(() {});
                },
                child: const Text("Go to Sign in Page"),
              ),
            ],
          );
        });
  }

  void showCreateQuoteDialog() {
    quoteTextEditingController.text = "";
    movieTextEditingController.text = "";
    showDialog(
      context: context,
      builder: (context) => MovieQuoteFormDialog(
        quoteTextEditingController: quoteTextEditingController,
        movieTextEditingController: movieTextEditingController,
        positiveAction: () {
          // var newMq = MovieQuote(
          //   quote: quoteTextEditingController.text,
          //   movie: movieTextEditingController.text,
          // );
          // setState(() {
          //   movieQuotes.add(newMq);
          // });

          // Spike test #1: Adding data
          // FirebaseFirestore.instance.collection("MovieQuotes").add({
          //   "quote": quoteTextEditingController.text,
          //   "movie": movieTextEditingController.text,
          // });
          MovieQuotesCollectionManager.instance.add(
            quote: quoteTextEditingController.text,
            movie: movieTextEditingController.text,
          );
        },
      ),
    );
  }
}
