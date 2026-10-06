import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'hero_banner_description.dart';
import 'narrative_blocks.dart';

class GridNarrativeDesktop extends StatelessWidget {
  final Project project;
  final bool usePointByPointUI;

  const GridNarrativeDesktop({
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

    final hasLeftGroup = hasBackstory || hasApproach;
    final hasRightGroup = hasRole || hasChallenge;

    Widget buildLeftGroup() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        );

    Widget buildRightGroup() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.description.isNotEmpty) ...[
          ExpandableDescription(text: project.description),
          const SizedBox(height: 32),
        ],
        if (hasLeftGroup && hasRightGroup)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildLeftGroup()),
              const SizedBox(width: 32),
              Expanded(child: buildRightGroup()),
            ],
          )
        else if (hasLeftGroup)
          buildLeftGroup()
        else if (hasRightGroup)
          buildRightGroup(),
        if (hasLeftGroup || hasRightGroup) const SizedBox(height: 16),
        if (hasSolution && hasOutcomes)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CardNarrativeBlock(
                  title: "The Solution",
                  icon: Icons.check_circle_outline_rounded,
                  iconColor: const Color(0xFF38BDF8),
                  blocks: project.solutionBlocks,
                  usePointByPoint: _usePt('solution'),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: CardNarrativeBlock(
                  title: "Key Outcomes",
                  icon: Icons.emoji_events_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  blocks: project.keyOutcomesBlocks,
                  usePointByPoint: _usePt('keyOutcomes'),
                ),
              ),
            ],
          )
        else if (hasSolution)
          CardNarrativeBlock(
            title: "The Solution",
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF38BDF8),
            blocks: project.solutionBlocks,
            usePointByPoint: _usePt('solution'),
          )
        else if (hasOutcomes)
          CardNarrativeBlock(
            title: "Key Outcomes",
            icon: Icons.emoji_events_outlined,
            iconColor: const Color(0xFFF59E0B),
            blocks: project.keyOutcomesBlocks,
            usePointByPoint: _usePt('keyOutcomes'),
          ),
        if (hasDifferent || hasLearnings) ...[
          const SizedBox(height: 16),
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
      ],
    );
  }
}
