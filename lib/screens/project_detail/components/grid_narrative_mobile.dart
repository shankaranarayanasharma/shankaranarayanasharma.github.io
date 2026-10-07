import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'hero_banner_description.dart';
import 'narrative_blocks.dart';

class GridNarrativeMobile extends StatelessWidget {
  final Project project;
  final bool usePointByPointUI;

  const GridNarrativeMobile({
    Key? key,
    required this.project,
    required this.usePointByPointUI,
  }) : super(key: key);

  bool _hasBlocks(List<NarrativeBlock> blocks) => blocks.isNotEmpty;

  bool _usePt(String sectionKey) =>
      project.isSectionPointByPoint(sectionKey, usePointByPointUI);

  @override
  Widget build(BuildContext context) {
    final hasBackstory = _hasBlocks(project.backstoryBlocks);
    final hasApproach = _hasBlocks(project.approachBlocks);
    final hasRole = _hasBlocks(project.myRoleBlocks);
    final hasChallenge = _hasBlocks(project.challengeBlocks);
    final hasSolution = _hasBlocks(project.solutionBlocks);
    final hasOutcomes = _hasBlocks(project.keyOutcomesBlocks);
    final hasDifferent = _hasBlocks(project.whatMakesThisDifferentBlocks);
    final hasLearnings = _hasBlocks(project.whatITookFromItBlocks);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.description.isNotEmpty) ...[
          ExpandableDescription(text: project.description),
          const SizedBox(height: 28),
        ],
        if (hasBackstory)
          TextNarrativeBlock(
            label: "THE BACKSTORY",
            icon: Icons.history_edu_rounded,
            blocks: project.backstoryBlocks,
            usePointByPoint: _usePt('backstory'),
          ),
        if (hasApproach)
          TextNarrativeBlock(
            label: "THE APPROACH",
            icon: Icons.alt_route_rounded,
            blocks: project.approachBlocks,
            usePointByPoint: _usePt('approach'),
          ),
        if (hasRole)
          CardNarrativeBlock(
            title: "My Role",
            icon: Icons.person_outline_rounded,
            iconColor: const Color(0xFF60A5FA),
            blocks: project.myRoleBlocks,
            usePointByPoint: _usePt('myRole'),
          ),
        if (hasChallenge)
          CardNarrativeBlock(
            title: "The Challenge",
            icon: Icons.warning_amber_rounded,
            iconColor: const Color(0xFFEF4444),
            blocks: project.challengeBlocks,
            usePointByPoint: _usePt('challenge'),
          ),
        if (hasSolution)
          CardNarrativeBlock(
            title: "The Solution",
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF38BDF8),
            blocks: project.solutionBlocks,
            usePointByPoint: _usePt('solution'),
          ),
        if (hasOutcomes)
          CardNarrativeBlock(
            title: "Key Outcomes",
            icon: Icons.emoji_events_outlined,
            iconColor: const Color(0xFFF59E0B),
            blocks: project.keyOutcomesBlocks,
            usePointByPoint: _usePt('keyOutcomes'),
          ),
        if (hasDifferent)
          TextNarrativeBlock(
            label: "WHAT MAKES THIS DIFFERENT",
            icon: Icons.adjust_rounded,
            accentColor: const Color(0xFF60A5FA),
            blocks: project.whatMakesThisDifferentBlocks,
            usePointByPoint: _usePt('whatMakesThisDifferent'),
          ),
        if (hasLearnings)
          TextNarrativeBlock(
            label: "KEY LEARNINGS",
            icon: Icons.school_outlined,
            accentColor: const Color(0xFF10B981),
            blocks: project.whatITookFromItBlocks,
            usePointByPoint: _usePt('whatITookFromIt'),
          ),
      ],
    );
  }
}
