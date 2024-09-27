import 'package:flutter/material.dart';
import 'package:moviequotes/models/movie_quote.dart';

class MovieQuoteRow extends StatelessWidget {
  final MovieQuote movieQuote;
  final void Function() onClick;

  const MovieQuoteRow({
    super.key,
    required this.movieQuote,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movieQuote.quote),
      subtitle: Text(movieQuote.movie),
    );
  }
}
