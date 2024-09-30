import 'package:flutter/material.dart';
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
      body: Center(
        child: Text(widget.movieQuote.toString()),
      ),
    );
  }
}
