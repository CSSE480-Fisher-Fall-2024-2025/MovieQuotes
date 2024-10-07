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

  StreamSubscription startListening(Function observer) =>
      _ref.snapshots().listen((QuerySnapshot querySnapshot) {
        latestMovieQuotes =
            querySnapshot.docs.map((doc) => MovieQuote.from(doc)).toList();
        observer();
      }, onError: (error) {
        print("Error listening for Movie Quotes $error");
      });

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }
}
