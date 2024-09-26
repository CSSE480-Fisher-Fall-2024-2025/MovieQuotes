import 'package:flutter/material.dart';

class MovieQuotesListPage extends StatefulWidget {
  const MovieQuotesListPage({super.key});

  @override
  State<MovieQuotesListPage> createState() => _MovieQuotesListPageState();
}

class _MovieQuotesListPageState extends State<MovieQuotesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Movie Quotes"),
      ),
      body: Text(
        "Hello",
        style: Theme.of(context).textTheme.headlineMedium,
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
