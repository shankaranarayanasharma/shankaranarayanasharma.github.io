import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class IPhoneMockupFrame extends StatelessWidget {
  final Widget child;
  final bool isHovered;
  final bool isVideo;
  final EdgeInsetsGeometry margin;

  const IPhoneMockupFrame({
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
      width: 235,
      height: 470,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1E),
        borderRadius: BorderRadius.circular(44),
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
            left: -4,
            top: 75,
            child: Container(
              width: 3,
              height: 22,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            left: -4,
            top: 110,
            child: Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            left: -4,
            top: 160,
            child: Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: -4,
            top: 125,
            child: Container(
              width: 3,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF383840),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(37),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(37),
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
                          width: 82,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F172A),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF1E293B),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ],
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
                          width: 36,
                          height: 2.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFF333338),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 7,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 95,
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
