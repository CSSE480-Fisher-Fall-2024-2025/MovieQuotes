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
      onTap: onClick,
      leading: const Icon(Icons.movie),
      title: Text(
        movieQuote.quote,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        movieQuote.movie,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
