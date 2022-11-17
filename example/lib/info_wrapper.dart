import 'package:flutter/material.dart';
import 'package:flutter_app_wrapper/flutter_app_wrapper.dart';

/// Shows information in a bar above a widget.
class InformationBarWrapper extends StatelessWidget {
  const InformationBarWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Information(
      child: AppWrapper(
        absorber: const InformationBar(),
        child: child,
      ),
    );
  }
}

class InformationBar extends StatelessWidget {
  const InformationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    );

    return Material(
      child: AnimatedBar(
        show: InformationScope.of(context),
        child: ColoredBox(
          color: Colors.orange,
          child: Padding(
            padding: topPadding,
            child: const Center(
              child: Text(
                'Information',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Information extends StatefulWidget {
  const Information({
    super.key,
    required this.child,
  });

  final Widget child;

  static InformationState? of(BuildContext context) {
    return context.findAncestorStateOfType<InformationState>();
  }

  @override
  State<Information> createState() => InformationState();
}

class InformationState extends State<Information> {
  bool showing = false;

  void toggleShowInfo() {
    setState(() {
      showing = !showing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InformationScope(
      showInformation: showing,
      child: widget.child,
    );
  }
}

class InformationScope extends InheritedWidget {
  const InformationScope({
    super.key,
    required this.showInformation,
    required super.child,
  });

  final bool showInformation;

  static bool of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<InformationScope>();
    return scope?.showInformation ?? false;
  }

  @override
  bool updateShouldNotify(InformationScope oldWidget) {
    return oldWidget.showInformation != showInformation;
  }
}
