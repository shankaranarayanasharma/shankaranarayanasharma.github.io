import 'package:flutter/material.dart';
import 'package:flutter_profile/models/Project.dart';
import 'package:flutter_profile/screens/project_detail/project_detail_body.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  final bool usePointByPointUI;

  const ProjectDetailsPage({
    Key? key,
    required this.project,
    this.usePointByPointUI = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E23), // Matching dark theme background
      body: SafeArea(
        child: ProjectDetailsBody(
          project: project,
          isMobile: true,
          usePointByPointUI: usePointByPointUI,
        ),
      ),
    );
  }
}
