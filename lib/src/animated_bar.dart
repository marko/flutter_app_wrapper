import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedBar extends StatefulWidget {
  const AnimatedBar({
    super.key,
    this.show = true,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOutCubic,
    required this.child,
  });

  final bool show;
  final Duration duration;
  final Curve curve;
  final Widget child;

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _createAnimation();
  }

  void _createAnimation() {
    _controller.duration = widget.duration;

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(AnimatedBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    _createAnimation();

    if (widget.show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1,
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}
