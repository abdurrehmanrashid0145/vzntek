import 'package:flutter/material.dart';

/// Helper class for creating staggered animations
/// Used for page entrance effects where elements appear in sequence
class StaggeredAnimation {
  final AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> slide;
  late Animation<double> scale;

  StaggeredAnimation({
    required this.controller,
    double beginDelay = 0.0,
    double endDelay = 1.0,
    Offset slideFrom = const Offset(0, 0.5),
  }) {
    // Fade in animation
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(beginDelay, endDelay, curve: Curves.easeOut),
      ),
    );

    // Slide animation
    slide = Tween<Offset>(
      begin: slideFrom,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(beginDelay, endDelay, curve: Curves.easeOutCubic),
      ),
    );

    // Scale animation
    scale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(beginDelay, endDelay, curve: Curves.easeOut),
      ),
    );
  }
}