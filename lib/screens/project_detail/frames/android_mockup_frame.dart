import 'package:flutter/material.dart';

class AndroidMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const AndroidMockupFrame({
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
    final glowColor = isHovered
        ? const Color(0xFF38BDF8).withValues(alpha: 0.25)
        : Colors.black.withValues(alpha: 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 235,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF18181C),
        borderRadius: BorderRadius.circular(28),
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
          Positioned(
            right: -4,
            top: 100,
            child: Container(
              width: 3,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: -4,
            top: 148,
            child: Container(
              width: 3,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(23),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF1E293B),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0F172A),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 30,
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFF333338),
                            borderRadius: BorderRadius.circular(1),
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
                          width: 80,
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
          ),
        ],
      ),
    );
  }
}
