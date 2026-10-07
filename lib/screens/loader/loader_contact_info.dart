import 'package:flutter/material.dart';

/// Step 4: Social Links & CTA Button matching attached reference image spacing
class LoaderContactInfo extends StatelessWidget {
  final Animation<double> animation;

  const LoaderContactInfo({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    final double iconSize = isDesktop ? 14 : (isTablet ? 13 : 12);
    final double textSize = isDesktop ? 12 : (isTablet ? 11 : 10);
    final double ctaHeight = isDesktop ? 30 : (isTablet ? 26 : 24);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final val = animation.value.clamp(0.0, 1.0);

        return Opacity(
          opacity: val,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row 1: LinkedIn & Twitter
              Wrap(
                spacing: 24,
                runSpacing: 8,
                children: [
                  _buildSocialItem(
                    icon: Icons.link_rounded,
                    text: "shankaranarayanasharma",
                    iconSize: iconSize,
                    textSize: textSize,
                    isSquare: true,
                    label: "in",
                  ),
                  _buildSocialItem(
                    icon: Icons.flutter_dash_rounded,
                    text: "shankaranarayanasharma",
                    iconSize: iconSize,
                    textSize: textSize,
                    isSquare: true,
                    label: "tw",
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Row 2: Website
              _buildSocialItem(
                icon: Icons.language_rounded,
                text: "shankaranarayanasharma.github.io",
                iconSize: iconSize,
                textSize: textSize,
                isSquare: false,
                label: "web",
              ),
              SizedBox(height: isDesktop ? 16 : 12),

              // CTA Button: OPEN TO MOBILE DEVELOPMENT OPPORTUNITIES
              Container(
                height: ctaHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 14 : 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF040A18).withValues(alpha: 0.90),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF007AFF),
                    width: 1.1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF007AFF).withValues(alpha: 0.22),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.work_rounded,
                      size: isDesktop ? 14 : 12,
                      color: const Color(0xFF38BDF8),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: isDesktop ? 11 : (isTablet ? 10 : 9),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: Colors.white,
                        ),
                        children: const [
                          TextSpan(text: "OPEN TO "),
                          TextSpan(
                            text: "MOBILE DEVELOPMENT",
                            style: TextStyle(color: Color(0xFF38BDF8)),
                          ),
                          TextSpan(text: " OPPORTUNITIES"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialItem({
    required IconData icon,
    required String text,
    required double iconSize,
    required double textSize,
    required bool isSquare,
    required String label,
  }) {
    Widget badge;
    if (label == "in") {
      badge = Container(
        width: iconSize + 3,
        height: iconSize + 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(
            "in",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: iconSize * 0.65,
            ),
          ),
        ),
      );
    } else {
      badge = Container(
        width: iconSize + 3,
        height: iconSize + 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isSquare
              ? BorderRadius.circular(3)
              : BorderRadius.circular(6),
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize * 0.75,
            color: Colors.black,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        badge,
        const SizedBox(width: 7),
        Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
