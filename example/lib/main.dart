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

  static const colors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        leading: const InformationCell(),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          final color = colors[index % colors.length];

          return ListTile(
            title: Text(color.toString()),
            leading: SizedBox(
              height: 50,
              width: 50,
              child: ColoredBox(color: color),
            ),
          );
        }),
      ),
    );
  }
}

class InformationCell extends StatelessWidget {
  const InformationCell({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Information.of(context)?.toggleShowInfo();
        },
        child: const Text('T'),
      ),
    );
  }
}
