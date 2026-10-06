import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class PlatformFilterTabs extends StatelessWidget {
  final List<String> platforms;
  final String selectedPlatform;
  final Map<String, List<String>> loadedMediaByPlatform;
  final ValueChanged<String> onSelectPlatform;
  final IconData Function(String) getIconForPlatform;

  const PlatformFilterTabs({
    Key? key,
    required this.platforms,
    required this.selectedPlatform,
    required this.loadedMediaByPlatform,
    required this.onSelectPlatform,
    required this.getIconForPlatform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (platforms.isEmpty) return const SizedBox();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: platforms.map((platform) {
          final isSelected = selectedPlatform == platform;
          final iconData = getIconForPlatform(platform);
          final count = loadedMediaByPlatform[platform]?.length ?? 0;

          return Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 16),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onSelectPlatform(platform),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryColor.withValues(alpha: 0.18)
                        : const Color(0xFF18181C),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? primaryColor
                          : Colors.white.withValues(alpha: 0.08),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        iconData,
                        size: 15,
                        color: isSelected ? primaryColor : Colors.white60,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        platform,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                      ),
                      if (count > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor.withValues(alpha: 0.3)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "$count",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? primaryColor
                                  : Colors.white38,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
