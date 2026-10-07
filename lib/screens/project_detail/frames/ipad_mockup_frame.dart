import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class IPadMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const IPadMockupFrame({
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
        : const Color(0xFF32323A);
    final glowColor = isHovered
        ? primaryColor.withValues(alpha: 0.25)
        : Colors.black.withValues(alpha: 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 360,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      top: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E293B),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
