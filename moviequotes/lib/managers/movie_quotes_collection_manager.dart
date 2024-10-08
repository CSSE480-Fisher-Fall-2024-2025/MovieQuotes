import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviequotes/models/movie_quote.dart';

class MovieQuotesCollectionManager {
  var latestMovieQuotes = <MovieQuote>[];
  final CollectionReference _ref;

  static final MovieQuotesCollectionManager instance =
      MovieQuotesCollectionManager._privateConstructor();

  MovieQuotesCollectionManager._privateConstructor()
      : _ref =
            FirebaseFirestore.instance.collection(kMovieQuotesCollectionPath);

  StreamSubscription startListening(Function observer) => _ref
          .orderBy(kMovieQuoteLastTouched, descending: true)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        latestMovieQuotes =
            querySnapshot.docs.map((doc) => MovieQuote.from(doc)).toList();
        observer();
      }, onError: (error) {
        print("Error listening for Movie Quotes $error");
      });

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  Future<void> add({
    required String quote,
    required String movie,
  }) {
    return _ref.add({
      kMovieQuoteQuote: quote,
      kMovieQuoteMovie: movie,
      kMovieQuoteLastTouched: Timestamp.now(),
    }).then((DocumentReference docRef) {
      print("The add is finished, the doc id was ${docRef.id}");
    }).catchError((error) {
      print("There was an error: $error");
    });
  }
}
