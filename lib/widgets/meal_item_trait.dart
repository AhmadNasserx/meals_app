import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    this.iconSize = 18,
    this.maxLines = 1,
    this.semanticLabel,
  });

  final IconData icon;
  final String label;

  /// Defaults to white (good over your dark image overlay). Override to use theme colors elsewhere.
  final Color? color;

  /// Slightly larger default for readability.
  final double iconSize;

  /// Ellipsize long labels instead of overflowing.
  final int maxLines;

  /// Optional accessibility label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.white;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: effectiveColor,
        );

    return Semantics(
      label: semanticLabel ?? label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: effectiveColor),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: textStyle ?? TextStyle(color: effectiveColor),
            ),
          ),
        ],
      ),
    );
  }
}
