import 'package:flutter/material.dart';

/// Step 2: Tagline scaled to fit custom card width
class LoaderTagline extends StatelessWidget {
  final Animation<double> animation;

  const LoaderTagline({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    final double fontSize = isDesktop ? 12 : (isTablet ? 11 : 10);
    final double iconSize = isDesktop ? 13 : (isTablet ? 12 : 11);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final val = animation.value.clamp(0.0, 1.0);

        return Opacity(
          opacity: val,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.rocket_launch_rounded,
                size: iconSize,
                color: const Color(0xFF38BDF8),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.90),
                      height: 1.2,
                    ),
                    children: const [
                      TextSpan(text: "Building scalable, production-ready "),
                      TextSpan(
                        text: "mobile applications",
                        style: TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
