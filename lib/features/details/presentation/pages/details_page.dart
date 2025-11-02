import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String message;

  const DetailsPage({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: textTheme.bodyMedium,
        ),
      ),
    );
  }
}
