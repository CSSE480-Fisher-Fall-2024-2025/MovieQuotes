import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviequotes/models/firestore_model_utils.dart';

const kMovieQuotesCollectionPath = "MovieQuotes";
const kMovieQuoteQuote = "quote";
const kMovieQuoteMovie = "movie";
const kMovieQuoteLastTouched = "lastTouched";

class MovieQuote {
  String? documentId;
  String quote;
  String movie;
  Timestamp lastTouched;

  MovieQuote({
    this.documentId,
    required this.quote,
    required this.movie,
    required this.lastTouched,
  });

  // Need for listening.
  MovieQuote.from(DocumentSnapshot doc)
      : this(
          documentId: doc.id,
          quote: FirestoreModelUtils.getStringField(doc, kMovieQuoteQuote),
          movie: FirestoreModelUtils.getStringField(doc, kMovieQuoteMovie),
          lastTouched: FirestoreModelUtils.getTimestampField(
              doc, kMovieQuoteLastTouched),
        );

  // The oppostie direction (needed MUCH later)
  Map<String, Object?> toJsonMap() => {
        kMovieQuoteQuote: quote,
        kMovieQuoteMovie: movie,
        kMovieQuoteLastTouched: lastTouched,
      };

  @override
  String toString() {
    return "Quote: $quote  from Movie: $movie";
  }
}
