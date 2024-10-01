import 'package:flutter/material.dart';
import 'package:moviequotes/components/display_card.dart';
import 'package:moviequotes/models/movie_quote.dart';

class MovieQuoteDetailPage extends StatefulWidget {
  final MovieQuote movieQuote;
  const MovieQuoteDetailPage({
    super.key,
    required this.movieQuote,
  });

  @override
  State<MovieQuoteDetailPage> createState() => _MovieQuoteDetailPageState();
}

class _MovieQuoteDetailPageState extends State<MovieQuoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quote"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              displayText: widget.movieQuote.quote,
            ),
            const SizedBox(
              height: 40.0,
            ),
            DisplayCard(
              labelText: "Movie:",
              iconData: Icons.movie_filter_outlined,
              displayText: widget.movieQuote.movie,
            ),
          ],
        ),
      ),
    );
  }
}
