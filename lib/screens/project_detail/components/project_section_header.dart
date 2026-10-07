import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;

  const SectionHeader({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                primaryColor.withValues(alpha: 0.4),
                Colors.transparent,
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
