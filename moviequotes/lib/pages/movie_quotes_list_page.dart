import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviequotes/components/movie_quote_form_dialog.dart';
import 'package:moviequotes/components/movie_quote_row.dart';
import 'package:moviequotes/managers/movie_quotes_collection_manager.dart';
import 'package:moviequotes/models/movie_quote.dart';
import 'package:moviequotes/pages/movie_quote_detail_page.dart';

class MovieQuotesListPage extends StatefulWidget {
  const MovieQuotesListPage({super.key});

  @override
  State<MovieQuotesListPage> createState() => _MovieQuotesListPageState();
}

class _MovieQuotesListPageState extends State<MovieQuotesListPage> {
  final quoteTextEditingController = TextEditingController();
  final movieTextEditingController = TextEditingController();
  StreamSubscription? movieQuotesSubscription;

  @override
  void initState() {
    super.initState();

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

    movieQuotesSubscription =
        MovieQuotesCollectionManager.instance.startListening(() {
      setState(() {});
    });

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
    MovieQuotesCollectionManager.instance
        .stopListening(movieQuotesSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Movie Quotes"),
      ),
      body: ListView(
        children: MovieQuotesCollectionManager.instance.latestMovieQuotes
            .map((mq) => MovieQuoteRow(
                  movieQuote: mq,
                  onClick: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieQuoteDetailPage(movieQuote: mq),
                      ),
                    );
                    setState(() {});
                  },
                ))
            .toList(),

        // children: List<Widget>.filled(
        //   60,
        //   const Text("I'm a list item!"),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateQuoteDialog();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
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
          FirebaseFirestore.instance.collection("MovieQuotes").add({
            "quote": quoteTextEditingController.text,
            "movie": movieTextEditingController.text,
          });
        },
      ),
    );
  }
}
