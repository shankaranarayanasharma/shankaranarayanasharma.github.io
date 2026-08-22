import 'package:flutter/material.dart';

import '../../../constants.dart';

class HeighLight extends StatefulWidget {
  const HeighLight({
    Key? key,
    required this.counter,
    this.label,
  }) : super(key: key);

  final Widget counter;
  final String? label;

  @override
  State<HeighLight> createState() => _HeighLightState();
}

class _HeighLightState extends State<HeighLight> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isHovered
              ? const Color(0xFF2B2B2E) // Hovered slightly lighter charcoal
              : const Color(0xFF1E1E22), // Normal card color
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered ? primaryColor : borderColor, // Glow gold/yellow on hover
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.counter,
            const SizedBox(height: 10),
            Text(
              widget.label!,
              style: TextStyle(
                color: isHovered ? Colors.white70 : bodyTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}