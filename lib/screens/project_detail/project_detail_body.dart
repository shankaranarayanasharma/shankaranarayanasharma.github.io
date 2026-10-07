import 'package:flutter/material.dart';
import 'package:flutter_profile/core/constants/app_strings.dart';
import 'package:flutter_profile/data/portfolio_data.dart';
import 'package:flutter_profile/models/Project.dart';
import 'package:flutter_profile/screens/project_detail/project_media_carousel.dart';

import 'components/project_engineering_challenges.dart';
import 'components/project_footer_switcher.dart';
import 'components/project_grid_narrative.dart';
import 'components/project_hero_banner.dart';
import 'components/project_section_header.dart';

class ProjectDetailsBody extends StatefulWidget {
  final Project project;
  final bool isMobile;
  final VoidCallback? onClose;
  final List<Project>? allProjects;
  final bool usePointByPointUI;

  const ProjectDetailsBody({
    Key? key,
    required this.project,
    required this.isMobile,
    this.onClose,
    this.allProjects,
    this.usePointByPointUI = false,
  }) : super(key: key);

  @override
  State<ProjectDetailsBody> createState() => _ProjectDetailsBodyState();
}

class _ProjectDetailsBodyState extends State<ProjectDetailsBody> {
  late Project _currentProject;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentProject = widget.project;
  }

  @override
  void didUpdateWidget(covariant ProjectDetailsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.project != widget.project) {
      setState(() {
        _currentProject = widget.project;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Project> get _projectsList {
    if (widget.allProjects != null && widget.allProjects!.isNotEmpty) {
      return widget.allProjects!;
    }
    return PortfolioData.projectsJson
        .map((json) => Project.fromJson(json))
        .toList();
  }

  void _switchProject(Project newProject) {
    setState(() {
      _currentProject = newProject;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = _projectsList;
    final currentIndex =
        list.indexWhere((p) => p.title == _currentProject.title);
    final prevIndex = currentIndex > 0 ? currentIndex - 1 : list.length - 1;
    final nextIndex = (currentIndex + 1) % list.length;

    final prevProject = list.isNotEmpty ? list[prevIndex] : null;
    final nextProject = list.isNotEmpty ? list[nextIndex] : null;

    final effectiveIsMobile =
        widget.isMobile || MediaQuery.of(context).size.width < 900;

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroBanner(
            project: _currentProject,
            onClose: widget.onClose,
            isMobile: effectiveIsMobile,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: effectiveIsMobile ? 18.0 : 48.0,
              right: effectiveIsMobile ? 18.0 : 48.0,
              top: 24.0,
              bottom: 36.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridNarrativeSection(
                  project: _currentProject,
                  isMobile: effectiveIsMobile,
                  usePointByPointUI: widget.usePointByPointUI,
                ),
                const SizedBox(height: 36),
                if (_currentProject.hasEngineeringChallenges) ...[
                  const SectionHeader(
                    label: "Engineering Challenges",
                    icon: Icons.developer_board_rounded,
                  ),
                  const SizedBox(height: 20),
                  EngineeringChallengesSection(
                    challenges: _currentProject.engineeringChallenges,
                    isMobile: effectiveIsMobile,
                  ),
                  const SizedBox(height: 36),
                ],
                SectionHeader(
                    label: AppStrings.mediaAndGallery,
                    icon: Icons.photo_library_rounded),
                const SizedBox(height: 20),
                ProjectMediaCarousel(
                  media: _currentProject.media,
                  mediaByPlatform: _currentProject.mediaByPlatform,
                  projectImage: _currentProject.image,
                  mediaHasBezel: _currentProject.mediaHasBezel,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          if (prevProject != null && nextProject != null && list.length > 1)
            ProjectFooterSwitcher(
              prevProject: prevProject,
              nextProject: nextProject,
              onSelectProject: _switchProject,
              isMobile: effectiveIsMobile,
            ),
        ],
      ),
    );
  }
}
