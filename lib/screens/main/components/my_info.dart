import 'package:flutter/material.dart';
import '../../../constants.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Rounded-square avatar with green online status dot
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF2B2B2C),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    "assets/images/IMG_7344.jpg",
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4EE1A0),
                      shape: BoxShape.circle,
                      border: Border.all(color: secondaryColor, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4EE1A0).withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // User Name
          const Text(
            "Shankaranarayana Sharma",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          // Subtitle Role Pill Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2B2B2C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Mobile Developer | iOS | Flutter",
              style: TextStyle(
                fontSize: 11,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
