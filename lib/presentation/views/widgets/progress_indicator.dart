// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double value;
  final Color color;

  const CustomProgressIndicator({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6,
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        color: color,
        minHeight: 6,
        borderRadius: BorderRadius.circular(3),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(
      delay: 1000.ms,
      duration: 1000.ms,
      color: color.withOpacity(0.2),
    );
  }
}