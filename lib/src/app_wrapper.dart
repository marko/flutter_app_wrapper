import 'dart:math';

import 'package:flutter/material.dart';

/// PaddingAbsorber
class AppWrapper extends StatelessWidget {
  const AppWrapper({
    super.key,
    this.direction = AxisDirection.up,
    required this.outer,
    required this.child,
  });

  final AxisDirection direction;
  final Widget outer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isReversed = axisDirectionIsReversed(direction);

    final MainAxisAlignment alignment =
        isReversed ? MainAxisAlignment.end : MainAxisAlignment.start;

    return LayoutBuilder(
      builder: (BuildContext outerContext, BoxConstraints outerConstraints) {
        return Flex(
          direction: axisDirectionToAxis(direction),
          mainAxisAlignment: alignment,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            outer,
            Expanded(
              child: LayoutBuilder(
                builder: (innerContext, innerConstraints) {
                  final data = _calculatePadding(
                    MediaQuery.of(context),
                    innerConstraints,
                    outerConstraints,
                  );

                  return MediaQuery(
                    data: data,
                    child: child,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  MediaQueryData _calculatePadding(
    MediaQueryData data,
    BoxConstraints innerConstraints,
    BoxConstraints outerConstraints,
  ) {
    final padding = data.padding;
    EdgeInsets newPadding;

    if (axisDirectionToAxis(direction) == Axis.horizontal) {
      final diff = outerConstraints.maxWidth - innerConstraints.maxWidth;

      if (direction == AxisDirection.left) {
        newPadding = padding.copyWith(
          left: max(0, padding.left - diff),
        );
      } else {
        newPadding = padding.copyWith(
          right: max(0, padding.right - diff),
        );
      }
    } else {
      final diff = outerConstraints.maxHeight - innerConstraints.maxHeight;

      if (direction == AxisDirection.up) {
        newPadding = padding.copyWith(
          top: max(0, padding.top - diff),
        );
      } else {
        newPadding = padding.copyWith(
          bottom: max(0, padding.bottom - diff),
        );
      }
    }

    return data.copyWith(padding: newPadding);
  }
}
