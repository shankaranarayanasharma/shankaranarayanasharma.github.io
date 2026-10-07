import 'package:flutter/material.dart';

class TabletMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const TabletMockupFrame({
    Key? key,
    required this.child,
    required this.isHovered,
    this.isVideo = false,
    this.margin = const EdgeInsets.only(right: 22, bottom: 10, top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isHovered
        ? const Color(0xFF38BDF8).withValues(alpha: 0.85)
        : const Color(0xFF2C2C34);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 360,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF161619),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: borderColor,
          width: isHovered ? 2.5 : 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? const Color(0xFF38BDF8).withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isHovered ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              child,
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F172A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 90,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
