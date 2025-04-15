import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetAnimation on Widget {
  Animate fadeInFromBottom({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 300),
    Offset offset = const Offset(0, 20),
  }) {
    return animate(delay: delay)
        .move(
          duration: duration,
          begin: offset,
        )
        .fade(duration: duration);
  }

  Animate fadeIn({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return animate(delay: delay).fade(duration: duration);
  }

  Animate scaleIn({
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) {
    return animate(delay: delay).scale(
      duration: duration,
      curve: curve,
    );
  }
}