import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({
    Key? key,
  }) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    // Skills ordered: iOS languages → Cross-platform → Tools
    final skills = [
      {"name": "Swift",          "asset": "assets/images/swift.svg"},
      {"name": "Objective-C",    "asset": "assets/images/objc.svg"},
      {"name": "SwiftUI",        "asset": "assets/images/swiftui.svg"},
      {"name": "Flutter",        "asset": "assets/images/Flutter.svg"},
      {"name": "Dart",           "asset": "assets/images/Dart.svg"},
      {"name": "Xcode",          "asset": "assets/images/Xcode.svg"},
      {"name": "VS Code",        "asset": "assets/images/vscode.svg"},
      {"name": "Android Studio", "asset": "assets/images/AndroidStudio.svg"},
      {"name": "Firebase",       "asset": "assets/images/Firebase.svg"},
      {"name": "GitHub",         "asset": "assets/images/github.svg"},
      {"name": "GitLab",         "asset": "assets/images/gitlab.svg"},
      {"name": "Jira",           "asset": "assets/images/jira.svg"},
      {"name": "Postman",        "asset": "assets/images/Postman.svg"},
      {"name": "Figma",          "asset": "assets/images/Figma.svg"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            "Skills",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Horizontal list of skills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(skills.length, (index) {
                final skill = skills[index];
                final isHovered = hoveredIndex == index;
                return MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = index),
                  onExit: (_) => setState(() => hoveredIndex = null),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Square box container with SVG brand logo
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: isHovered
                                ? const Color(0xFF2B2B2E) // Lighter charcoal on hover
                                : const Color(0xFF1E1E22), // Normal dark charcoal
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isHovered ? primaryColor : borderColor,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(22),
                          child: SvgPicture.asset(
                            skill["asset"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Label text underneath the box
                        Text(
                          skill["name"]!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isHovered ? Colors.white : Colors.grey,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 32),
          // Custom horizontal progress/scroll indicator bar
          LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth = constraints.maxWidth;
              // Active portion is 60% of total track width
              final activeWidth = totalWidth * 0.6;
              final inactiveWidth = totalWidth * 0.4;
              return Row(
                children: [
                  Container(
                    width: activeWidth,
                    height: 3,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                  Container(
                    width: inactiveWidth,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2B2D),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
