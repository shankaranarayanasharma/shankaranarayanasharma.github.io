import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'block_content_renderer.dart';
import 'code_window_widget.dart';

class EngineeringChallengeTextContent extends StatelessWidget {
  final EngineeringChallenge challenge;

  const EngineeringChallengeTextContent({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (challenge.problem != null && challenge.problem!.isNotEmpty) ...[
          const Text(
            "THE PROBLEM",
            style: TextStyle(
              color: Color(0xFFF97316),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            challenge.problem!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
        ],
        if (challenge.approach != null && challenge.approach!.isNotEmpty) ...[
          const Text(
            "THE APPROACH",
            style: TextStyle(
              color: Color(0xFF60A5FA),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            challenge.approach!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
        ],
        if (challenge.blocks.isNotEmpty) ...[
          const SizedBox(height: 14),
          BlockContentRenderer(
            blocks: challenge.blocks,
            accentColor: const Color(0xFF60A5FA),
          ),
        ],
      ],
    );
  }
}

class EngineeringChallengeRightContent extends StatelessWidget {
  final EngineeringChallenge challenge;

  const EngineeringChallengeRightContent({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (challenge.code != null && challenge.code!.isNotEmpty) {
      return CodeWindowWidget(
        code: challenge.code!,
        language: challenge.codeLanguage,
      );
    }
    if (challenge.image != null && challenge.image!.isNotEmpty) {
      final imgPath = challenge.image!;
      final isAsset = imgPath.startsWith('assets/');
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: isAsset
              ? Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _errorContainer(),
                )
              : Image.network(
                  imgPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _errorContainer(),
                ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _errorContainer() {
    return Container(
      height: 180,
      color: Colors.white.withValues(alpha: 0.05),
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.white38),
      ),
    );
  }
}
