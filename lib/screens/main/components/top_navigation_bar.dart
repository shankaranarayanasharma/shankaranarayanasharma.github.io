import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class TopNavigationBar extends StatelessWidget {
  final int activeSectionIndex;
  final Function(int) onSelectSection;

  const TopNavigationBar({
    Key? key,
    required this.activeSectionIndex,
    required this.onSelectSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuItems = ["About", "Projects", "Experience", "Skills", "Contact"];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF242426),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(menuItems.length, (index) {
          final isSelected = activeSectionIndex == index;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onSelectSection(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  menuItems[index],
                  style: TextStyle(
                    color: isSelected ? primaryColor : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
