import 'package:flutter/material.dart';

/// Step 1: Responsive Title & Profession scaled to fit custom card width
class LoaderHeaderText extends StatelessWidget {
  final Animation<double> nameProgress;
  final Animation<double> roleProgress;

  const LoaderHeaderText({
    Key? key,
    required this.nameProgress,
    required this.roleProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    final double nameFontSize = isDesktop ? 32 : (isTablet ? 25 : 20);
    final double roleFontSize = isDesktop ? 16 : (isTablet ? 14 : 12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: nameProgress,
          builder: (context, child) {
            final val = nameProgress.value.clamp(0.0, 1.0);
            return Opacity(
              opacity: val,
              child: Text(
                "Shankaranarayana\nSharma",
                style: TextStyle(
                  fontSize: nameFontSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.05,
                  letterSpacing: -0.4,
                  shadows: [
                    Shadow(
                      color: const Color(0xFF007AFF).withValues(alpha: 0.4 * val),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: isDesktop ? 6 : 4),
        AnimatedBuilder(
          animation: roleProgress,
          builder: (context, child) {
            final val = roleProgress.value.clamp(0.0, 1.0);
            return Opacity(
              opacity: val,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: roleFontSize,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                  children: const [
                    TextSpan(
                      text: "Mobile Developer",
                      style: TextStyle(color: Color(0xFF38BDF8)),
                    ),
                    TextSpan(
                      text: "  |  ",
                      style: TextStyle(color: Colors.white54),
                    ),
                    TextSpan(
                      text: "iOS",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: "  |  ",
                      style: TextStyle(color: Colors.white54),
                    ),
                    TextSpan(
                      text: "Flutter",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
