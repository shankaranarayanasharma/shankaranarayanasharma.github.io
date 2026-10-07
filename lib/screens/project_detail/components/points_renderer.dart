import 'package:flutter/material.dart';

class PointsRenderer extends StatelessWidget {
  final List<String> items;
  final Color tint;
  final String? iconStyle;

  const PointsRenderer({
    Key? key,
    required this.items,
    required this.tint,
    this.iconStyle,
  }) : super(key: key);

  IconData _getIconForStyle(String? style) {
    if (style == 'check') return Icons.check_circle_outline_rounded;
    if (style == 'dash') return Icons.remove_rounded;
    if (style == 'star') return Icons.star_rounded;
    if (style == 'target') return Icons.adjust_rounded;
    if (style == 'bullet') return Icons.circle;
    return Icons.adjust_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconForStyle(iconStyle);
    final isDash = iconStyle == 'dash';
    final isNumber = iconStyle == 'number' || iconStyle == 'numbered';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final p = entry.value;

        Widget prefixWidget;
        if (isNumber) {
          prefixWidget = Text(
            "${index + 1}. ",
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.bold,
              fontSize: 13.5,
            ),
          );
        } else if (isDash) {
          prefixWidget = Text(
            "— ",
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          );
        } else {
          prefixWidget = Icon(
            iconData,
            color: tint,
            size: iconStyle == 'bullet' ? 6 : 15,
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isNumber || isDash
                      ? 2
                      : (iconStyle == 'bullet' ? 6 : 2),
                ),
                child: prefixWidget,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  p,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
