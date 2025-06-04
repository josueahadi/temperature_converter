import 'package:flutter/material.dart';

/// A reusable card widget with consistent styling for the application
class AppCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppCard({
    super.key,
    required this.child,
    this.elevation = 4.0,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );
  }
}
