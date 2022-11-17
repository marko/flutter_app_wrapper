import 'package:flutter/material.dart';

import 'info_wrapper.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) {
        child ??= const SizedBox();

        return InformationBarWrapper(child: child);
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Information.of(context)?.toggleShowInfo();
          },
          child: const Text('Toggle info bar'),
        ),
      ),
    );
  }
}
