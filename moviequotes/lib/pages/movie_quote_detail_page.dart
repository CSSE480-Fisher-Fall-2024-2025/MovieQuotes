import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviequotes/components/display_card.dart';
import 'package:moviequotes/components/movie_quote_form_dialog.dart';
import 'package:moviequotes/managers/movie_quote_document_manager.dart';
import 'package:moviequotes/managers/movie_quotes_collection_manager.dart';
import 'package:moviequotes/models/movie_quote.dart';

class MovieQuoteDetailPage extends StatefulWidget {
  // final MovieQuote movieQuote;
  final String documentId;

  const MovieQuoteDetailPage({
    super.key,
    // required this.movieQuote,
    required this.documentId,
  });

  @override
  State<MovieQuoteDetailPage> createState() => _MovieQuoteDetailPageState();
}

class _MovieQuoteDetailPageState extends State<MovieQuoteDetailPage> {
  final quoteTextEditingController = TextEditingController();
  final movieTextEditingController = TextEditingController();
  StreamSubscription? movieQuoteSubscription;

  @override
  void initState() {
    super.initState();
    movieQuoteSubscription = MovieQuoteDocumentManager.instance.startListening(
      documentId: widget.documentId,
      observer: () {
        print("Received the document");
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    quoteTextEditingController.dispose();
    movieTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quote"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              showEditQuoteDialog();
            },
            tooltip: "Edit",
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // print("You pressed the delete button");
              MovieQuote deletedMq =
                  MovieQuoteDocumentManager.instance.latestMovieQuote!;
              MovieQuoteDocumentManager.instance.delete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Quote deleted"),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      // MovieQuotesCollectionManager.instance.add(
                      //   quote: deletedMq.quote,
                      //   movie: deletedMq.movie,
                      // );

                      MovieQuoteDocumentManager.instance.restore(deletedMq);
                    },
                  ),
                ),
              );

              Navigator.of(context).pop();
            },
            tooltip: "Delete",
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      // body: Center(
      //   child: Text(widget.movieQuote.toString()),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            DisplayCard(
              labelText: "Quote:",
              iconData: Icons.format_quote_outlined,
              // displayText: widget.movieQuote.quote,
              displayText: MovieQuoteDocumentManager.instance.quote,
            ),
            const SizedBox(
              height: 40.0,
            ),
            DisplayCard(
              labelText: "Movie:",
              iconData: Icons.movie_filter_outlined,
              // displayText: widget.movieQuote.movie,
              displayText: MovieQuoteDocumentManager.instance.movie,
            ),
          ],
        ),
      ),
    );
  }

  void showEditQuoteDialog() {
    quoteTextEditingController.text = MovieQuoteDocumentManager.instance.quote;
    movieTextEditingController.text = MovieQuoteDocumentManager.instance.movie;
    showDialog(
      context: context,
      builder: (context) => MovieQuoteFormDialog(
        quoteTextEditingController: quoteTextEditingController,
        movieTextEditingController: movieTextEditingController,
        positiveAction: () {
          // setState(() {
          // widget.movieQuote.quote = quoteTextEditingController.text;
          // widget.movieQuote.movie = movieTextEditingController.text;
          // });

          MovieQuoteDocumentManager.instance.update(
            quote: quoteTextEditingController.text,
            movie: movieTextEditingController.text,
          );
        },
      ),
    );
  }
}
