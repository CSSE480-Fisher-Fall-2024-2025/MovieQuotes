import 'package:flutter/material.dart';

class MovieQuoteFormDialog extends StatelessWidget {
  final TextEditingController quoteTextEditingController;
  final TextEditingController movieTextEditingController;
  final void Function() positiveAction;

  const MovieQuoteFormDialog({
    super.key,
    required this.quoteTextEditingController,
    required this.movieTextEditingController,
    required this.positiveAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Movie Quote"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: quoteTextEditingController,
            decoration: const InputDecoration(
              labelText: "Quote",
              border: UnderlineInputBorder(),
            ),
          ),
          TextField(
            controller: movieTextEditingController,
            decoration: const InputDecoration(
              labelText: "Movie",
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // New so must be better?
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            positiveAction();
            Navigator.pop(context);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
