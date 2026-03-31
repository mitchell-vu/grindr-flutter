import 'package:flutter/material.dart';

/// Clamps overscroll at the top edge only, while preserving the default
/// (bouncy) iOS physics at the bottom.
class TopClampedScrollPhysics extends AlwaysScrollableScrollPhysics {
  const TopClampedScrollPhysics({super.parent});

  @override
  TopClampedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TopClampedScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Clamp at the top — prevent scrolling above minScrollExtent.
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    // Let the parent handle the bottom edge (bouncy on iOS).
    return super.applyBoundaryConditions(position, value);
  }
}
