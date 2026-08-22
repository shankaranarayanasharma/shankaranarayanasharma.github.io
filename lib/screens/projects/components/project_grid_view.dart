import 'package:flutter/material.dart';
import 'package:flutter_profile/constants.dart';
import 'package:flutter_profile/screens/projects/components/project_card.dart';

class ProjectGridView extends StatelessWidget {
  const ProjectGridView({
    Key? key,
    required this.projects,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.35,
    this.staticCount,
  }) : super(key: key);

  final List<Project> projects;
  final int crossAxisCount;
  final double childAspectRatio;
  final int? staticCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: staticCount ?? projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => ProjectCard(
        blog: projects[index],
      ),
    );
  }
}
