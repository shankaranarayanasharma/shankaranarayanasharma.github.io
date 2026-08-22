import 'package:flutter/material.dart';

/// Step 3: Technology Chips Row scaled to fit custom card width
class LoaderTechStack extends StatelessWidget {
  final Animation<double> animation;

  const LoaderTechStack({
    Key? key,
    required this.animation,
  }) : super(key: key);

  static const List<Map<String, String>> _techItems = [
    {"label": "Objective-C", "icon": "c"},
    {"label": "Swift", "icon": "swift"},
    {"label": "SwiftUI", "icon": "swiftui"},
    {"label": "Flutter", "icon": "flutter"},
    {"label": "Firebase", "icon": "firebase"},
    {"label": "REST APIs", "icon": "api"},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    final double chipHeight = isDesktop ? 26 : (isTablet ? 23 : 21);
    final double fontSize = isDesktop ? 10.5 : (isTablet ? 10 : 9.5);
    final double hPadding = isDesktop ? 8 : (isTablet ? 7 : 6);
    final double iconSize = isDesktop ? 11 : (isTablet ? 10 : 9);
    final double spacing = isDesktop ? 6 : 4;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final overallVal = animation.value.clamp(0.0, 1.0);

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(_techItems.length, (index) {
            final startFraction = index / _techItems.length;
            final itemVal =
                ((overallVal - (startFraction * 0.5)) / 0.5).clamp(0.0, 1.0);

            final scale = Curves.easeOutBack.transform(itemVal);
            final opacity = itemVal.clamp(0.0, 1.0);
            final item = _techItems[index];

            return Transform.scale(
              scale: scale < 0 ? 0 : scale,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  height: chipHeight,
                  padding: EdgeInsets.symmetric(horizontal: hPadding),
                  decoration: BoxDecoration(
                    color: const Color(0xFF060C19).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF007AFF).withValues(alpha: 0.75),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF007AFF).withValues(alpha: 0.15),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTechIcon(item["icon"]!, iconSize),
                      const SizedBox(width: 4),
                      Text(
                        item["label"]!,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildTechIcon(String type, double size) {
    if (type == "c") {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF007AFF),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            "C",
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.65,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    IconData iconData = Icons.code_rounded;
    if (type == "swift" || type == "swiftui" || type == "flutter") {
      iconData = Icons.flutter_dash_rounded;
    } else if (type == "firebase") {
      iconData = Icons.local_fire_department_rounded;
    } else if (type == "api") {
      iconData = Icons.cloud_sync_rounded;
    }

    return Icon(iconData, size: size, color: const Color(0xFF38BDF8));
  }
}
