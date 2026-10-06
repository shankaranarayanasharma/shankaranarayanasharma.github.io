import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';

import 'grid_narrative_desktop.dart';
import 'grid_narrative_mobile.dart';

class GridNarrativeSection extends StatelessWidget {
  final Project project;
  final bool isMobile;
  final bool usePointByPointUI;

  const GridNarrativeSection({
    Key? key,
    required this.project,
    required this.isMobile,
    this.usePointByPointUI = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return GridNarrativeMobile(
        project: project,
        usePointByPointUI: usePointByPointUI,
      );
    }

    return GridNarrativeDesktop(
      project: project,
      usePointByPointUI: usePointByPointUI,
    );
  }
}
