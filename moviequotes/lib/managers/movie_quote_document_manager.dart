import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviequotes/models/movie_quote.dart';

class MovieQuoteDocumentManager {
  MovieQuote? latestMovieQuote;
  final CollectionReference _ref;

  static final MovieQuoteDocumentManager instance =
      MovieQuoteDocumentManager._privateConstructor();

  MovieQuoteDocumentManager._privateConstructor()
      : _ref =
            FirebaseFirestore.instance.collection(kMovieQuotesCollectionPath);

  StreamSubscription startListening({
    required String documentId,
    required Function observer,
  }) =>
      _ref.doc(documentId).snapshots().listen(
          (DocumentSnapshot documentSnapshot) {
        latestMovieQuote = MovieQuote.from(documentSnapshot);
        observer();
      }, onError: (error) {
        print("Error listening for Movie Quote $error");
      });

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  void delete() {
    // TODO: Do this later.  Delete the one you most recently got.
  }

  // Comment out add, since update will have similarities.
  Future<void> update({
    required String quote,
    required String movie,
  }) {
    return _ref.doc(latestMovieQuote!.documentId!).update({
      kMovieQuoteQuote: quote,
      kMovieQuoteMovie: movie,
      kMovieQuoteLastTouched: Timestamp.now(),
    }).catchError((error) {
      print("There was an error: $error");
    });
  }

  String get quote => latestMovieQuote?.quote ?? "";
  String get movie => latestMovieQuote?.movie ?? "";
}
