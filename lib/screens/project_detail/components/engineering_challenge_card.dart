import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'engineering_challenge_content.dart';

class EngineeringChallengeCard extends StatefulWidget {
  final EngineeringChallenge challenge;
  final bool isMobile;

  const EngineeringChallengeCard({
    Key? key,
    required this.challenge,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<EngineeringChallengeCard> createState() =>
      _EngineeringChallengeCardState();
}

class _EngineeringChallengeCardState extends State<EngineeringChallengeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;
    final hasRightContent = challenge.code != null ||
        challenge.image != null ||
        challenge.blocks.any((b) =>
            b.type == NarrativeBlockType.image ||
            b.type == NarrativeBlockType.images ||
            b.type == NarrativeBlockType.video);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(widget.isMobile ? 18 : 24),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF1F1F24) : const Color(0xFF161619),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF60A5FA).withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? const Color(0xFF60A5FA).withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF222228),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    challenge.number ?? '01',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    challenge.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.isMobile ? 16 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            const SizedBox(height: 20),
            if (widget.isMobile || !hasRightContent) ...[
              EngineeringChallengeTextContent(challenge: challenge),
              if (hasRightContent) ...[
                const SizedBox(height: 20),
                EngineeringChallengeRightContent(challenge: challenge),
              ],
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: EngineeringChallengeTextContent(challenge: challenge),
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    flex: 6,
                    child: EngineeringChallengeRightContent(challenge: challenge),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
