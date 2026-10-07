import 'package:flutter/material.dart';

class WebMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const WebMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? const Color(0xFF60A5FA).withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 500,
      height: 370,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? const Color(0xFF60A5FA).withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF141418),
              borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFF27C93F), shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(width: 14),
                const Icon(Icons.arrow_back_rounded,
                    color: Colors.white38, size: 14),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white38, size: 14),
                const SizedBox(width: 8),
                const Icon(Icons.refresh_rounded,
                    color: Colors.white38, size: 14),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22222A),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lock_rounded,
                            color: Colors.white38, size: 10),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "https://localhost:8080/app",
                            style: TextStyle(
                                color: Colors.white60, fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(13)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
