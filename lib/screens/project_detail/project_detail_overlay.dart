import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/screens/project_detail/project_detail_body.dart';

class ProjectDetailsOverlay extends StatefulWidget {
  final Project project;
  final bool usePointByPointUI;

  const ProjectDetailsOverlay({
    Key? key,
    required this.project,
    this.usePointByPointUI = false,
  }) : super(key: key);

  @override
  State<ProjectDetailsOverlay> createState() => _ProjectDetailsOverlayState();
}

class _ProjectDetailsOverlayState extends State<ProjectDetailsOverlay> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final dialogWidth = isMobile ? screenWidth * 0.96 : 960.0;
    final dialogHeight = isMobile
        ? MediaQuery.of(context).size.height * 0.95
        : MediaQuery.of(context).size.height * 0.90;

    return Center(
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        decoration: BoxDecoration(
          // Deep semi-transparent dark — glass effect
          color: const Color(0xFF121214).withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 60,
              spreadRadius: 0,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
          child: ProjectDetailsBody(
            project: widget.project,
            isMobile: isMobile,
            usePointByPointUI: widget.usePointByPointUI,
            onClose: () {
              if (mounted && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
