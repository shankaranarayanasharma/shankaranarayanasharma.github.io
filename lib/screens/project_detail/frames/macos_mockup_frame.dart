import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class MacOSMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const MacOSMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? primaryColor.withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 500,
      height: 370,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? primaryColor.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF16161B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                const SizedBox(width: 7),
                Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                const SizedBox(width: 7),
                Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        color: Color(0xFF27C93F), shape: BoxShape.circle)),
                const SizedBox(width: 16),
                const Expanded(
                  child: Center(
                    child: Text(
                      "macOS App Showcase",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
