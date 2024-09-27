import 'package:flutter/material.dart';
import 'package:moviequotes/components/movie_quote_row.dart';
import 'package:moviequotes/models/movie_quote.dart';

class MovieQuotesListPage extends StatefulWidget {
  const MovieQuotesListPage({super.key});

  @override
  State<MovieQuotesListPage> createState() => _MovieQuotesListPageState();
}

class _MovieQuotesListPageState extends State<MovieQuotesListPage> {
  // List<MovieQuote> movieQuotes = [];
  var movieQuotes = <MovieQuote>[];

  @override
  void initState() {
    super.initState();
    movieQuotes.add(
      MovieQuote(
        quote: "I'll be back!",
        movie: "The Terminator",
      ),
    );
    movieQuotes.add(
      MovieQuote(
        quote: "Everything is Awesome",
        movie: "The Lego Movie",
      ),
    );
    movieQuotes.add(MovieQuote(
      quote:
          "Hello. My name is Inigo Montoya. You killed my father. Prepare to die.",
      movie: "The Princess Bride",
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
        children: movieQuotes
            .map((mq) => MovieQuoteRow(
                  movieQuote: mq,
                  onClick: () {
                    print("You clicked on $mq");
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
          print("You clicked the FAB");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
