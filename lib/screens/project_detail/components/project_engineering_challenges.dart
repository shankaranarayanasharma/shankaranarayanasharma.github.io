import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'engineering_challenge_card.dart';

class EngineeringChallengesSection extends StatelessWidget {
  final List<EngineeringChallenge> challenges;
  final bool isMobile;

  const EngineeringChallengesSection({
    Key? key,
    required this.challenges,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: challenges.map((challenge) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: EngineeringChallengeCard(
            challenge: challenge,
            isMobile: isMobile,
          ),
        );
      }).toList(),
    );
  }
}
